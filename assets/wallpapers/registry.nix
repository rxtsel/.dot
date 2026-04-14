{
  defaultPack = "solarized";
  defaultMode = "dark";
  defaultLayoutPreference = "auto";

  packs = {
    solarized = {
      dark = {
        layouts = {
          single = [
            {
              path = ./packs/solarized/dark/single-1920x1080-v1.jpg;
              width = 1920;
              height = 1080;
              priority = 100;
            }
            {
              path = ./packs/solarized/dark/single-1920x1080-v2.jpg;
              width = 1920;
              height = 1080;
              priority = 90;
            }
          ];
        };
      };
    };
  };
}
