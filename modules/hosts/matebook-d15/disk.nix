{...}: {
  flake.modules.nixos.matebookD15Disk = {
    disko.enableConfig = false;

    disko.devices.disk.main = {
      device = "/dev/disk/by-id/nvme-SAMSUNG_MZVLB256HBHQ-00000_S4GGNF0N575857";
      type = "disk";
      content = {
        type = "gpt";
        partitions = {
          ESP = {
            size = "512M";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
              mountOptions = ["fmask=0022" "dmask=0022"];
            };
          };
          root = {
            size = "100%";
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/";
            };
          };
        };
      };
    };
  };
}
