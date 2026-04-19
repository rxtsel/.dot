{config, ...}: let
  username = config.preferences.user.name;
  homeDir = config.users.users.${username}.home;

  wp = mode: file: width: height: priority: {
    path = "${homeDir}/.dotfiles/assets/wallpapers/packs/solarized/${mode}/${file}";
    inherit width height priority;
  };
in {
  defaultPack = "solarized";
  defaultMode = "dark";
  defaultLayoutPreference = "auto";

  packs = {
    solarized = {
      dark = {
        wallpapers = [
          (wp "dark" "abstract-3840x2160.png" 3840 2160 70)
          (wp "dark" "arch-8000x4500.png" 8000 4500 90)
          (wp "dark" "chinatown-7680x4320.png" 7680 4320 85)
          (wp "dark" "city-buildings-1920x1080.png" 1920 1080 70)
          (wp "dark" "computer-1920x1080.jpg" 1920 1080 70)
          (wp "dark" "crane-3206x1800.jpg" 3206 1800 70)
          (wp "dark" "crow-1920x1080.png" 1920 1080 80)
          (wp "dark" "cubes-1920x1080.png" 1920 1080 65)
          (wp "dark" "darkness-4579x2616.jpg" 4579 2616 80)
          (wp "dark" "dragon-fractal-5120x2880.png" 5120 2880 90)
          (wp "dark" "flowers-1920x1080.jpeg" 1920 1080 70)
          (wp "dark" "geom-1920x1080.png" 1920 1080 70)
          (wp "dark" "k-1920x1080.png" 1920 1080 70)
          (wp "dark" "pacman-1920x1080.png" 1920 1080 75)
          (wp "dark" "pacman2-2040x1080.png" 2040 1080 70)
          (wp "dark" "palettes-7680x4320.jpg" 7680 4320 85)
          (wp "dark" "root-1920x1080.png" 1920 1080 70)
          (wp "dark" "sea1_1920x1080.png" 1920 1080 65)
          (wp "dark" "sea2_1920x1080.png" 1920 1080 65)
          (wp "dark" "sherlock-1920x1080.png" 1920 1080 75)
          (wp "dark" "solarized-3840x2160.jpg" 3840 2160 80)
          (wp "dark" "something-8000x4500.png" 8000 4500 85)
          (wp "dark" "stripes1-2048x1152.png" 2048 1152 65)
          (wp "dark" "stripes2-2048x1152.png" 2048 1152 65)
          (wp "dark" "stripes3-2048x1152.png" 2048 1152 65)
          (wp "dark" "stripes4-2048x1152.png" 2048 1152 65)
          (wp "dark" "vim-1920x1080.png" 1920 1080 75)
          (wp "dark" "wall1-2560x1440.png" 2560 1440 80)
          (wp "dark" "wall2-2560x1440.png" 2560 1440 80)
          (wp "dark" "wall3-2560x1440.png" 2560 1440 80)
          (wp "dark" "waves-1920x1080.png" 1920 1080 75)
        ];
      };

      light = {
        wallpapers = [
          (wp "light" "stripes1-2048x1152.png" 2048 1152 70)
          (wp "light" "stripes2-2048x1152.png" 2048 1152 70)
          (wp "light" "stripes3-2048x1152.png" 2048 1152 70)
          (wp "light" "stripes4-2048x1152.png" 2048 1152 70)
        ];
      };
    };
  };
}
