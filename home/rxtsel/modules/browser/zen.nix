{ inputs, config, ... }:

{
  imports = [
    inputs.zen-browser.homeModules.twilight
  ];

  programs.zen-browser = {
    enable = true;

    profiles.default = {
      containersForce = true;
      spacesForce = true;

      settings = {
        "zen.browser.layout" = "sidebar-top-toolbar";
        "zen.tabs.show-newtab-vertical" = false;
        "zen.tabs.newtab-button.move-to-top" = false;
      };

      containers = {
        Personal = {
          id = 1;
          color = "purple";
          icon = "fingerprint";
        };

        Work = {
          id = 2;
          color = "blue";
          icon = "briefcase";
        };
      };

      spaces = let
        c = config.programs.zen-browser.profiles.default.containers;
      in {
        Personal = {
          id = "08d53c84-f65c-4acd-b7cf-1e700e319a95";
          position = 1000;
          icon = "🍉";
          container = c.Personal.id;
        };

        Work = {
          id = "5a395fd5-868d-47d0-8701-eb8cded626ce";
          position = 2000;
          icon = "👾";
          container = c.Work.id;
        };

        University = {
          id = "959a66e3-8c00-4980-85b7-2d3649d50fdd";
          position = 3000;
          icon = "🎓";
          container = c.Personal.id;
        };
      };
    };

    policies = let
      mkExtensionSettings = builtins.mapAttrs (_: pluginId: {
        install_url = "https://addons.mozilla.org/firefox/downloads/latest/${pluginId}/latest.xpi";
        installation_mode = "force_installed";
      });
    in {
      OfferToSaveLogins = false;
      PasswordManagerEnabled = false;

      AutofillAddressEnabled = false;
      AutofillCreditCardEnabled = false;

      DisablePocket = true;
      DisableFirefoxStudies = true;
      DisableFeedbackCommands = true;
      NoDefaultBookmarks = true;

      DisableTelemetry = true;
      DontCheckDefaultBrowser = true;

      DisableAppUpdate = true;

      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };

      DNSOverHTTPS = {
        Enabled = true;
        ProviderURL = "https://cloudflare-dns.com/dns-query";
        Locked = true;
      };

      Preferences = {
        "network.trr.mode" = {
          Value = 3;
          Status = "locked";
        };

        "network.trr.uri" = {
          Value = "https://cloudflare-dns.com/dns-query";
          Status = "locked";
        };

        "privacy.userContext.enabled" = {
          Value = true;
          Status = "locked";
        };

        "privacy.userContext.ui.enabled" = {
          Value = true;
          Status = "locked";
        };

        "browser.tabs.loadInBackground" = {
          Value = false;
          Status = "locked";
        };

        "browser.ctrlTab.sortByRecentlyUsed" = {
          Value = true;
          Status = "locked";
        };

        "browser.tabs.warnOnClose" = {
          Value = true;
          Status = "locked";
        };

        "browser.tabs.showNewTabButton" = {
          Value = false;
          Status = "locked";
        };

        "browser.download.useDownloadDir" = {
          Value = false;
          Status = "locked";
        };

        "browser.download.alwaysOpenPanel" = {
          Value = true;
          Status = "locked";
        };

        "zen.view.compact.enable-at-startup" = {
          Value = true;
          Status = "locked";
        };

        "zen.view.compact.hide-toolbar" = {
          Value = true;
          Status = "locked";
        };

        "zen.view.compact.hide-tabbar" = {
          Value = true;
          Status = "locked";
        };

        "font.name.sans-serif.x-western" = {
          Value = "SF Pro Display";
          Status = "locked";
        };

        "font.name.serif.x-western" = {
          Value = "New York";
          Status = "locked";
        };

        "font.name.monospace.x-western" = {
          Value = "SF Mono";
          Status = "locked";
        };

        "font.size.variable.x-western" = {
          Value = 16;
          Status = "locked";
        };

        "font.size.fixed.x-western" = {
          Value = 13;
          Status = "locked";
        };
      };

      ExtensionSettings = mkExtensionSettings {
        "{446900e4-71c2-419f-a6a7-df9c091e268b}" = "bitwarden-password-manager";
        "uBlock0@raymondhill.net" = "ublock-origin";
        "{d7742d87-e61d-4b78-b8a1-b469842139fa}" = "vimium-ff";
        "{50864413-c4c8-43b0-80b8-982c4a368ac9}" = "visbug";
        "@react-devtools" = "react-devtools";
        "wappalyzer@crunchlabz.com" = "wappalyzer";
      };
    };
  };
}

