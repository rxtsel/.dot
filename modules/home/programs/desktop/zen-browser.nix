{inputs, ...}: {
  flake.modules.homeManager.zen-browser = {...}: let
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

    mkExtensionSettings = builtins.mapAttrs (_: pluginId: {
      install_url = "https://addons.mozilla.org/firefox/downloads/latest/${pluginId}/latest.xpi";
      installation_mode = "force_installed";
    });
  in {
    imports = [
      inputs.zen-browser.homeModules.beta
    ];

    programs.zen-browser = {
      enable = true;
      setAsDefaultBrowser = true;

      profiles.default = {
        containersForce = true;
        spacesForce = true;

        settings = {
          "zen.browser.layout" = "sidebar-top-toolbar";
          "zen.tabs.show-newtab-vertical" = false;
          "zen.tabs.newtab-button.move-to-top" = false;
        };

        inherit containers;

        spaces = {
          Personal = {
            id = "08d53c84-f65c-4acd-b7cf-1e700e319a95";
            position = 1000;
            icon = "🍉";
            container = containers.Personal.id;
          };

          Work = {
            id = "5a395fd5-868d-47d0-8701-eb8cded626ce";
            position = 2000;
            icon = "👾";
            container = containers.Work.id;
          };
        };
      };

      policies = {
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
          "uBlock0@raymondhill.net" = "ublock-origin";
          "{50864413-c4c8-43b0-80b8-982c4a368ac9}" = "visbug";
          "@react-devtools" = "react-devtools";
          "wappalyzer@crunchlabz.com" = "wappalyzer";
        };
      };
    };
  };
}
