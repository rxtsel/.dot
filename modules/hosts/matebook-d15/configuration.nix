{ self, ... }:
{
  flake.nixosModules.matebookD15Configuration =
    { pkgs, ... }:
    {
      imports = [
        self.nixosModules.matebookD15Hardware
        self.nixosModules.nix
        self.nixosModules.fonts
        self.nixosModules.bluetooth
        self.nixosModules.notifications
        self.nixosModules.niri
        self.nixosModules.fcitx5
        self.nixosModules.waybar
        self.nixosModules.neovim
        self.nixosModules.git
        self.nixosModules.ssh
        self.nixosModules.starship
        self.nixosModules.fish
        self.nixosModules.lazygit
        self.nixosModules.vicinae
        self.nixosModules.swaybg
        self.nixosModules.cursorTheme
        self.nixosModules.gammastep
      ];

      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;
      boot.loader.efi.efiSysMountPoint = "/boot";

      networking.hostName = "matebook-d15";

      networking.networkmanager.enable = true;

      time.timeZone = "America/Bogota";

      i18n.defaultLocale = "en_US.UTF-8";
      console = {
        font = "Lat2-Terminus16";
        keyMap = "dvorak";
      };

      users.users.rxtsel = {
        isNormalUser = true;
        extraGroups = [ "wheel" ];
      };

      services.libinput.enable = true;

      security.rtkit.enable = true;
      services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
      };

      environment.systemPackages = with pkgs; [
        zoxide
        yazi
        brightnessctl
        tree
        opencode
        eza
        bat
      ];

      system.stateVersion = "25.11";
    };
}
