{ self, ... }:
{
  flake.nixosModules.profileCommon = {
    imports = [
      self.nixosModules.coreOptions
      self.nixosModules.coreCommon
      self.nixosModules.coreUser
      self.nixosModules.coreBasePackages
      self.nixosModules.nix
      self.nixosModules.fonts
      self.nixosModules.bluetooth
      self.nixosModules.fcitx5
      self.nixosModules.neovim
      self.nixosModules.starship
      self.nixosModules.fish
      self.nixosModules.zoxide
      self.nixosModules.git
      self.nixosModules.ssh
      self.nixosModules.lazygit
    ];
  };
}
