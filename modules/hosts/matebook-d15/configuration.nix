{ self, ... }:
{
  flake.nixosModules.matebookD15Configuration =
    { pkgs, ... }:
    {
      imports = [
        self.nixosModules.matebookD15Hardware
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
        # self.nixosModules.vicinae
        self.nixosModules.swaybg
        self.nixosModules.cursorTheme
        self.nixosModules.direnv
      ];

      # Use the systemd-boot EFI boot loader.
      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;
      boot.loader.efi.efiSysMountPoint = "/boot";

      networking.hostName = "matebook-d15";

      # Configure network connections interactively with nmcli or nmtui.
      networking.networkmanager.enable = true;

      time.timeZone = "America/Bogota";

      i18n.defaultLocale = "en_US.UTF-8";
      console = {
        font = "Lat2-Terminus16";
        keyMap = "dvorak";
      };

      users.users.rxtsel = {
        isNormalUser = true;
        extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
      };

      # Enable touchpad support (enabled default in most desktopManager).
      services.libinput.enable = true;

      # rtkit (optional, recommended) allows Pipewire to use the realtime scheduler for increased performance.
      security.rtkit.enable = true;
      services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
      };

      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
      ];

      nixpkgs.config.allowUnfree = true;

      environment.systemPackages = with pkgs; [
        zoxide
        yazi
        brightnessctl
        tree
        opencode
        eza
      ];

      system.stateVersion = "25.11";
    };
}
