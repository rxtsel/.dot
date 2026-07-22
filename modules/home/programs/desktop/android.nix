{
  flake.modules.nixos.android = {
    pkgs,
    config,
    ...
  }: {
    nixpkgs.config = {
      allowUnfree = true;
      android_sdk.accept_license = true;
    };

    environment.systemPackages = with pkgs; [
      android-studio
      android-tools
    ];

    users.users.${config.preferences.user.name}.extraGroups = [
      "kvm"
      "adbusers"
    ];
  };
}
