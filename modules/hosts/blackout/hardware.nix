{
  flake.modules.nixos.blackoutHardware = {
    config,
    lib,
    modulesPath,
    ...
  }: {
    imports = [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];
    boot = {
      initrd = {
        availableKernelModules = [
          "nvme"
          "xhci_pci"
          "ahci"
          "usbhid"
          "usb_storage"
          "sd_mod"
        ];
        kernelModules = [];

        luks.devices."cryptroot".device = "/dev/disk/by-uuid/68ae0178-0ffb-4411-9876-2ba9148b1a64";
      };
      kernelModules = ["kvm-amd"];
      extraModulePackages = [];
    };
    fileSystems = {
      "/" = {
        device = "/dev/mapper/cryptroot";
        fsType = "btrfs";
        options = ["subvol=@"];
      };

      "/nix" = {
        device = "/dev/mapper/cryptroot";
        fsType = "btrfs";
        options = ["subvol=@nix"];
      };

      "/var" = {
        device = "/dev/mapper/cryptroot";
        fsType = "btrfs";
        options = ["subvol=@var"];
      };

      "/boot" = {
        device = "/dev/disk/by-uuid/8B9D-E87B";
        fsType = "vfat";
        options = [
          "fmask=0022"
          "dmask=0022"
        ];
      };
    };

    swapDevices = [
      {device = "/swapfile";}
    ];

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };
  };
}
