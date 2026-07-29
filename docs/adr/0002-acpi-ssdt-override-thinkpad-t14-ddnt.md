# ADR 0002: ACPI SSDT Override for Lenovo ThinkPad T14 Gen 2 Intel Firmware Bug

- Status: Accepted
- Date: 2026-07-29

## Context

The Lenovo ThinkPad T14 Gen 2 Intel firmware contains an ACPI defect in one of the DPTF SSDTs.

The thermal sensor `SEN4` implements the `_TMP` method, which invokes:

```asl
\_SB.PC00.RP09.PEGP.DDNT(Local0)
```

However, the firmware only declares `DDNT` as an `External` symbol and never provides an implementation. During ACPI execution the kernel reports:

```text
ACPI BIOS Error (bug): Could not resolve symbol [\_SB.PC00.RP09.PEGP.DDNT], AE_NOT_FOUND
ACPI Error: Aborting method \_SB.PC00.LPCB.EC.SEN4._TMP
```

As a consequence:

- `thermal_zone6` (`SEN4`) is disabled.
- Temperature readings from that zone are unavailable.
- Every boot generates ACPI firmware errors.

Disassembling all firmware ACPI tables confirmed that no implementation of `DDNT` exists anywhere in the shipped firmware. The firmware references a method that was never provided.

Linux provides an official mechanism for replacing or extending ACPI tables during early boot by loading AML files from an initrd archive, making it possible to work around firmware defects without patching the kernel or modifying firmware.

## Decision

Implement a minimal SSDT that defines the missing `DDNT` method:

```asl
DefinitionBlock ("", "SSDT", 2, "RXTS", "DDNTFIX", 0x00000001)
{
    External (\_SB.PC00.RP09.PEGP, DeviceObj)

    Scope (\_SB.PC00.RP09.PEGP)
    {
        Method (DDNT, 1, NotSerialized)
        {
            Return (Zero)
        }
    }
}
```

The SSDT is compiled into AML using `iasl`, packaged into an uncompressed ACPI initrd archive, and built as a Nix derivation under `pkgs/acpi-ddnt/`.

The package is exposed through the flake's `perSystem.packages` surface (`packages.acpi-ddnt`) following the same pattern established for other packages in this repository. A dedicated NixOS module (`flake.modules.nixos.acpiDdnt`) consumes the package via `inputs.self.packages.${system}.acpi-ddnt` and adds the resulting cpio archive to `boot.initrd.prepend`. This keeps package construction strictly separate from host configuration and respects the dendritic architecture described in ADR 0001.

Hosts that require the workaround include `acpiDdnt` in their NixOS module list. Hosts that do not are unaffected.

## Consequences

### Advantages

- Eliminates the firmware ACPI errors at boot.
- Restores the `SEN4` thermal zone (`thermal_zone6`).
- Requires no kernel patches and no firmware modifications.
- Fully declarative and reproducible.
- Uses the kernel's supported ACPI table override mechanism (`CONFIG_ACPI_TABLE_UPGRADE`).
- Follows the existing repository architecture without introducing new patterns.

### Drawbacks

- The system depends on an ACPI initrd override during early boot.
- Future BIOS updates from Lenovo may fix the firmware defect, making the override a no-op (harmless, but worth removing when confirmed).
- The stub implementation returns `Zero`. This resolves the missing symbol and allows ACPI evaluation to continue, but does not guarantee meaningful data from the associated sensor. The thermal zone reports a constant value, which is likely a placeholder for a GPU thermal sensor absent on integrated-graphics-only configurations.

## Validation

After reboot the kernel log confirmed successful load of the custom table:

```text
ACPI: SSDT ACPI table found in initrd
ACPI: Table Upgrade: install [SSDT- RXTS DDNTFIX]
```

Post-override results:

- No `AE_NOT_FOUND` ACPI errors reported.
- `thermal_zone6 (SEN4)` is no longer disabled.
- The thermal zone exposes a value through sysfs.
- The system boots cleanly without the previous firmware exception.

## Future work

If a future Lenovo BIOS update ships a real implementation of `DDNT`, or if the correct implementation can be recovered from another ThinkPad model with a discrete GPU, the stub in `pkgs/acpi-ddnt/SSDT-DDNT.dsl` should be replaced with that implementation. Until then the current stub is the minimal, least-invasive fix that restores correct ACPI execution.

## Related docs

- Architecture: `docs/adr/0001-dendritic-architecture-and-home-manager-adoption.md`
- Source + module: `modules/nixos/hardware/` (`acpi-ddnt.nix`, `SSDT-DDNT.dsl`)
- Kernel documentation: https://cdn.kernel.org/doc/html/latest/admin-guide/acpi/initrd_table_override.html
