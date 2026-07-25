{
  flake.modules.nixos.virtualization = {
    pkgs,
    config,
    ...
  }: {
    virtualisation.libvirtd = {
      enable = true;

      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = false;
        swtpm.enable = true;

        vhostUserPackages = with pkgs; [
          virtiofsd
        ];
      };
    };

    programs.virt-manager.enable = true;
    virtualisation.spiceUSBRedirection.enable = true;

    users.users.${config.preferences.user.name}.extraGroups = [
      "libvirtd"
      "kvm"
    ];

    environment.systemPackages = with pkgs; [
      dnsmasq
    ];

    networking.firewall.trustedInterfaces = [
      "virbr0"
    ];
  };
}
