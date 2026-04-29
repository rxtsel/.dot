{lib, ...}: {
  flake.modules.homeManager.thunderbird = {config, ...}: {
    options.services.thunderbird.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable Thunderbird mail client";
    };

    config = lib.mkIf config.services.thunderbird.enable {
      home.sessionVariables = {
        MOZ_ENABLE_WAYLAND = "1";
      };

      programs.thunderbird = {
        enable = true;

        settings = {
          # Disable welcome / start / support / donation pages on startup
          "mailnews.start_page.enabled" = false;
          "mailnews.start_page.override_url" = "";
          "mailnews.start_page.url" = "";
          # Best-effort disabling of promotional / donation content
          "mail.promo.enabled" = false;
          "mail.provider.enabled" = false;
          "mail.donation.enabled" = false;
          # Allow remote content
          "mailnews.message_display.disable_remote_image" = false;
          # Send Do Not Track header when loading remote content
          "privacy.donottrackheader.enabled" = true;
          # Force DNS-over-HTTPS only
          "network.trr.mode" = 3;
          "network.trr.uri" = "https://cloudflare-dns.com/dns-query";
          "network.trr.confirmationNS" = "skip";
          # Enable inline spell checking while typing
          "mail.spellcheck.inline" = true;
          "mail.compose.spellcheck.before_send" = true;
          # Disable global search/indexer
          "mailnews.database.global.indexer.enabled" = false;
          # Reduce some UI/background overhead
          "mail.biff.show_alert" = false;
          "mail.biff.play_sound" = false;
          "mail.shell.checkDefaultClient" = false;
          # Conservative disk cache tuning
          "browser.cache.disk.enable" = true;
          "browser.cache.memory.enable" = true;
          # Conversation-related features can feel heavier in some setups
          "mail.threadpane.use_correspondents" = false;
        };

        profiles.default = {
          isDefault = true;
          accountsOrder = ["gmail"];
        };
      };
    };
  };
}
