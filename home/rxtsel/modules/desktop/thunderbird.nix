{ config, ... }:

{
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
      # Cloudflare DoH endpoint
      "network.trr.uri" = "https://cloudflare-dns.com/dns-query";
      # Skip confirmation DNS check
      "network.trr.confirmationNS" = "skip";
      # Enable inline spell checking while typing
      "mail.spellcheck.inline" = true;
      # Check spelling before sending emails
      "mail.compose.spellcheck.before_send" = true;
    };

    profiles.default = {
      isDefault = true;
      accountsOrder = [ "gmail" ];
    };
  };

  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = "1";
  };

  # Autostart Thunderbird with the graphical session (systemd user)
  systemd.user.services.thunderbird = {
    Unit = {
      Description = "Thunderbird Mail Client";
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };

    Service = {
      ExecStart = "${config.programs.thunderbird.package}/bin/thunderbird";
      Restart = "no";
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
