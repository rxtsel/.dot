{inputs, ...}: {
  perSystem = {pkgs, ...}: {
    packages.acpi-ddnt = pkgs.stdenv.mkDerivation {
      pname = "acpi-ddnt";
      version = "1";

      src = ./SSDT-DDNT.dsl;

      nativeBuildInputs = [
        pkgs.acpica-tools
        pkgs.cpio
      ];

      dontUnpack = true;

      installPhase = ''
        mkdir -p kernel/firmware/acpi "$out"
        cp "$src" SSDT-DDNT.dsl
        iasl -p SSDT-DDNT -sa SSDT-DDNT.dsl
        cp SSDT-DDNT.aml kernel/firmware/acpi/SSDT-DDNT.aml
        find kernel | cpio -H newc --create > "$out/SSDT-DDNT.cpio"
      '';
    };
  };

  flake.modules.nixos.acpiDdnt = {pkgs, ...}: {
    boot.initrd.prepend = [
      "${inputs.self.packages.${pkgs.stdenv.hostPlatform.system}.acpi-ddnt}/SSDT-DDNT.cpio"
    ];
  };
}
