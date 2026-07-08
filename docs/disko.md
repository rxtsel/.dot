# Disk layout (disko)

Each host declares its disk layout in `disk.nix` using [disko](https://github.com/nix-community/disko).
This makes disk partitioning reproducible and documented as code.

## Finding your disk ID

Before writing a `disk.nix`, identify your disk's stable ID:

```bash
ls /dev/disk/by-id/ | grep -v part
```

Use the result as the `device` value in your `disk.nix`. Prefer the `by-id` path over `/dev/sdX` or `/dev/nvmeXnY` since it is stable across reboots.

## Installing a new machine with disko

From a NixOS live ISO, run disko to partition, format and mount the disk:

```bash
sudo nix --experimental-features "nix-command flakes" \
  run github:nix-community/disko/latest -- \
  --mode destroy,format,mount \
  /path/to/modules/hosts/<hostname>/disk.nix
```

Then install NixOS normally (`nixos-install --flake ...`).

## Letting disko manage mounts in NixOS

By default, `disk.nix` sets `disko.enableConfig = false` so the existing
`fileSystems` entries in `hardware.nix` remain the source of truth.
This is safe for machines that were not installed with disko.

Once a machine has been installed with disko, switch to full declarative mount management:

1. Set `disko.enableConfig = true` in the host's `disk.nix`.
2. Remove the `fileSystems` and `swapDevices` blocks from `hardware.nix`
   (disko generates them from the disk config).
3. Run `sudo nixos-rebuild switch --flake .`.

After this, `hardware.nix` only needs to carry kernel modules and hardware-specific
options — disk mounts are owned by disko.
