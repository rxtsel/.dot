{ pkgs, ... }:

{
  programs.thunderbird = {
    enable = true;

    profiles = {
      all = {
        isDefault = true;
        settings = { };
      };
    };

    settings = {
      "mailnews.start_page.enabled" = false;
      "mailnews.message_display.disable_remote_image" = false;
      "privacy.donottrackheader.enabled" = true;
    };

  };

  home.packages = with pkgs; [ thunderbird ];
}
