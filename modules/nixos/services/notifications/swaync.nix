{
  flake.nixosModules.notificationsSwaync =
    {
      pkgs,
      lib,
      config,
      ...
    }:

    let
      username = config.preferences.user.name;
      homeDir = config.users.users.${username}.home;

      swayncStyle = ''
        /* --- colors.css (wallust generate) --- */
        @import url("${homeDir}/.config/swaync/colors.css");

        :root {
        	--notification-icon-size: 96px;
        	--mpris-album-art-icon-size: 96px;

        	--radius: 8px;
        	--pad: 11px;

        	/* Common alpha levels */
        	--bg-floating: 0.50;
        	--bg-center: 0.55;
        	--bg-card: 0.80;

        	--btn-bg: 0.30;
        	--btn-bg-soft: 0.20;
        	--btn-bg-strong: 0.40;
        }

        /* -----------------------------------------------------
         * Base / Reset
         * ----------------------------------------------------- */
        * {
        	all: unset;
        	font-family: "SF Pro Display", "CaskaydiaCove Nerd Font Propo";
        	font-size: 16px;
        	color: @foreground;
        	transition: 200ms;
        }

        /* Avoid blank background */
        .blank-window { background: transparent; }

        /* -----------------------------------------------------
         * Shared Surfaces
         * ----------------------------------------------------- */
        .surface-floating {
        	background: alpha(@background, var(--bg-floating));
        	border-radius: var(--radius);
        	box-shadow: 0 20px 25px -5px rgb(0 0 0 / 0.1), 0 8px 10px -6px rgb(0 0 0 / 0.1);
        }

        .surface-center {
        	background: alpha(@background, var(--bg-center));
        	border-radius: var(--radius);
        	box-shadow: 0 20px 25px -5px rgb(0 0 0 / 0.1), 0 8px 10px -6px rgb(0 0 0 / 0.1);
        }

        /* -----------------------------------------------------
         * Notifications (floating)
         * ----------------------------------------------------- */
        .notification-row { outline: none; margin: 0; padding: 0; }

        .floating-notifications.background .notification-row .notification-background {
        	background: alpha(@background, var(--bg-floating));
        	border-radius: var(--radius);
        	padding: var(--pad);
        	margin: 12px 12px 0 0;
        	box-shadow: 0 20px 25px -5px rgb(0 0 0 / 0.1), 0 8px 10px -6px rgb(0 0 0 / 0.1);
        	min-height: 46px;
        }

        .image {
        	margin: 0 20px 0 0;
        	border-radius: var(--radius);
        }

        .summary {
        	font-weight: 800;
        	font-size: 1rem;
        }

        .body {
        	font-size: 1rem;
        }

        /* Close button (shared) */
        .close-button {
        	padding: 2px;
        	border-radius: 999px;
        	background-color: alpha(@foreground, var(--btn-bg));
        	font-size: 11px;
        }

        .close-button:hover {
        	background-color: alpha(@background, 0.6);
        }

        .close-button:active {
        	background-color: @color4;
        }

        /* Progress colors */
        .notification.critical progress,
        .notification.low progress,
        .notification.normal progress {
        	background-color: @color4;
        }

        /* -----------------------------------------------------
         * Control Center
         * ----------------------------------------------------- */
        .control-center {
        	background: alpha(@background, var(--bg-center));
        	border-radius: var(--radius);
        	padding: 10px 30px;
        	box-shadow: 0 20px 25px -5px rgb(0 0 0 / 0.1), 0 8px 10px -6px rgb(0 0 0 / 0.1);
        }

        /* Control center notification cards */
        .control-center .notification-row .notification-background,
        .control-center .notification-row .notification-background .notification.critical {
        	background-color: alpha(@background, var(--bg-card));
        	border-radius: var(--radius);
        	padding: var(--pad);
        	margin: 12px 20px 0 0;
        }

        .control-center .notification-row .notification-background {
        	padding: 11px 0;
        	margin: 5px 0;
        }

        .control-center .notification-row .notification-background .notification.critical {
        	color: @color1;
        }

        .control-center .notification-row .notification-background .notification .notification-content {
        	padding: 12px;
        }

        .control-center .notification-row .notification-background .notification > *:last-child > * {
        	min-height: 3.4em;
        }

        /* Actions */
        .notification-action {
        	background: alpha(@color4, 0.2);
        	border-radius: var(--radius);
        	margin: 6px;
        }

        .notification-action:hover,
        .notification-action:active {
        	background-color: alpha(@background, 0.6);
        }

        /* -----------------------------------------------------
         * Tooltips / Progress
         * ----------------------------------------------------- */
        progressbar, progress, trough {
        	border-radius: 6px;
        }

        /* -----------------------------------------------------
         * Widget: Title (header)
         * ----------------------------------------------------- */
        .widget-title {
        	font-size: 1rem;
        }

        .widget-title button {
        	background: alpha(@foreground, var(--btn-bg));
        	border-radius: 4px;
        	padding: 2px 10px;
        	margin: 2px;
        	font-size: 16px;
        	min-width: 30px;
        	min-height: 30px;
        }

        .widget-title button:hover {
        	background-color: @color4;
        }

        .widget-title button:active {
        	background-color: @background;
        }

        /* -----------------------------------------------------
         * Groups
         * ----------------------------------------------------- */
        .notification-group,
        .group-header {
        	margin: 8px 0;
        }

        .notification-group-header,
        .group-header {
        	background: alpha(@background, 0.6);
        	border-radius: var(--radius);
        	padding: 8px 12px;
        	margin: 4px 0;
        }

        /* Shared button base */
        .btn {
        	background: alpha(@foreground, var(--btn-bg));
        	border-radius: 4px;
        }

        /* Group buttons */
        .notification-group .notification-group-header button,
        .notification-group-collapse-button,
        .group-header button,
        .group-header .collapse-button,
        .notification-group-buttons button {
        	background: alpha(@foreground, var(--btn-bg));
        	border-radius: 4px;
        	padding: 6px 10px;
        	margin: 2px;
        	font-size: 14px;
        	min-width: 30px;
        	min-height: 30px;
        }

        .notification-group .notification-group-header button:hover,
        .notification-group-collapse-button:hover,
        .group-header button:hover,
        .group-header .collapse-button:hover,
        .notification-group-buttons button:hover {
        	background: alpha(@color4, var(--btn-bg-strong));
        }

        .notification-group .notification-group-header button:active,
        .notification-group-collapse-button:active,
        .group-header button:active,
        .group-header .collapse-button:active,
        .notification-group-buttons button:active {
        	background: @color4;
        }

        /* Clear buttons */
        .notification-group-close-button,
        .clear-group-button,
        .group-header .clear-button,
        .notification-group .clear-all-button {
        	background: alpha(@color1, var(--btn-bg));
        	border-radius: 4px;
        	padding: 4px 8px;
        	font-size: 12px;
        	min-width: 24px;
        	min-height: 24px;
        }

        .notification-group-close-button:hover,
        .clear-group-button:hover,
        .group-header .clear-button:hover,
        .notification-group .clear-all-button:hover {
        	background: alpha(@color1, 0.6);
        }

        .notification-group-close-button:active,
        .clear-group-button:active,
        .group-header .clear-button:active,
        .notification-group .clear-all-button:active {
        	background: @color1;
        }

        .notification-group-body {
        	margin-left: 8px;
        	padding-left: 8px;
        }

        /* -----------------------------------------------------
         * Widget: Buttons grid
         * ----------------------------------------------------- */
        .widget-buttons-grid { margin-bottom: 16px; }

        .widget-buttons-grid > flowbox,
        .widget-buttons-grid > flowbox > flowboxchild {
        	margin: 0;
        	padding: 0;
        }

        .widget-buttons-grid > flowbox > flowboxchild > button {
        	background: alpha(@foreground, var(--btn-bg));
        	border-radius: 4px;
        	padding: 6px 40px;
        	margin: 0 5px 10px 5px;
        	min-width: 30px;
        	min-height: 30px;
        }

        .widget-buttons-grid > flowbox > flowboxchild > button label {
        	font-size: 20px;
        	margin: 0;
        	padding: 0;
        }

        .widget-buttons-grid > flowbox > flowboxchild > button:hover,
        .widget-buttons-grid > flowbox > flowboxchild > button.toggle:checked {
        	background: @color4;
        }

        /* -----------------------------------------------------
         * Widget: Volume
         * ----------------------------------------------------- */
        .widget-volume {
        	border-radius: var(--radius);
        	margin: 10px -10px 26px 6px;
        }

        .widget-volume label {
        	font-size: 24px;
        	min-width: 30px;
        }

        .widget-volume button {
        	background: alpha(@foreground, var(--btn-bg-soft));
        	border-radius: 4px;
        	padding: 6px 10px;
        	margin: 0 10px;
        	min-width: 20px;
        	min-height: 20px;
        }

        .widget-volume trough,
        .per-app-volume trough {
        	background: alpha(@foreground, var(--btn-bg));
        	border-radius: var(--radius);
        	margin: 0 0 0 20px;
        }

        trough highlight {
        	background: @color4;
        	border-radius: var(--radius);
        }

        trough slider {
        	background: alpha(@foreground, var(--btn-bg));
        	border-radius: var(--radius);
        	min-height: 8px;
        }

        .per-app-volume {
        	margin: 10px 10px 0 2px;
        }

        .per-app-volume trough {
        	margin: 0 60px 10px 25px;
        }

        /* -----------------------------------------------------
         * Widget: MPRIS
         * ----------------------------------------------------- */
        @define-color mpris-album-art-overlay rgba(0, 0, 0, 0.55);
        @define-color mpris-button-hover rgba(0, 0, 0, 0.50);

        .widget-mpris {
        	background: transparent;
        	border-radius: var(--radius);
        }

        .widget-mpris .widget-mpris-player {
        	padding: 16px;
        	background-color: @mpris-album-art-overlay;
        	border-radius: var(--radius);
        }

        .widget-mpris .widget-mpris-player button {
        	background: alpha(@mpris-button-hover, 0.8);
        	min-width: 40px;
        	min-height: 40px;
        	border-radius: 4px;
        }

        .widget-mpris .widget-mpris-player button:hover {
        	background: alpha(@mpris-button-hover, 0.6);
        }

        /* Hidden next/prev buttons */
        .control-center .widget-mpris .flat .horizontal {
        	min-height: 0;
        	min-width: 0;
        	margin: 0 -100px;
        }

        .widget-mpris .widget-mpris-player .widget-mpris-album-art {
        	border-radius: var(--radius);
        }

        .widget-mpris .widget-mpris-player .widget-mpris-title {
        	font-weight: bold;
        	font-size: 1.25rem;
        }

        .widget-mpris .widget-mpris-player .widget-mpris-subtitle {
        	font-size: 1.1rem;
        }

        .widget-mpris .widget-mpris-player > box > button {
        	padding: 8px;
        	border-radius: 4px;
        }

        .widget-mpris .widget-mpris-player > box > button:hover {
        	background-color: alpha(@background, 0.2);
        }

        /* -----------------------------------------------------
         * Widget: DND
         * ----------------------------------------------------- */
        .widget-dnd {
        	padding: 20px 0;
        	border-radius: 4px;
        	font-size: large;
        }

        .widget-dnd > switch {
        	border-radius: 4px;
        	background: alpha(@foreground, var(--btn-bg));
        	padding: 2px;
        	min-width: 60px;
        	min-height: 30px;
        }

        .widget-dnd > switch:checked {
        	background: @color4;
        }

        .widget-dnd > switch slider {
        	background: alpha(@foreground, 0.6);
        	border-radius: 4px;
        }

        .widget-dnd > switch:checked slider {
        	background: @foreground;
        }

        /* -----------------------------------------------------
         * Hidden scrollbars
         * ----------------------------------------------------- */
        .control-center scrollbar,
        .control-center scrollbar contents,
        .control-center scrollbar slider,
        .control-center scrollbar slider:hover,
        .control-center scrollbar slider:active,
        .control-center scrollbar trough,
        .control-center .notification-row scrollbar,
        .control-center .notification-row scrollbar thumb,
        .control-center .notification-row scrollbar thumb:hover {
        	background: transparent;
        	min-width: 1px;
        	margin-right: -100px;
        }
      '';

      swayncConfig = {
        "$schema" = "/etc/xdg/swaync/configSchema.json";
        positionX = "right";
        positionY = "top";
        cssPriority = "user";
        control-center-width = 400;
        control-center-height = 860;
        control-center-margin-top = 8;
        control-center-margin-bottom = 0;
        control-center-margin-right = 8;
        control-center-margin-left = 0;
        notification-window-width = 480;
        notification-body-image-height = 100;
        notification-body-image-width = 200;
        timeout = 10;
        timeout-low = 2;
        timeout-critical = 6;
        fit-to-screen = false;
        keyboard-shortcuts = true;
        image-visibility = "when-available";
        transition-time = 200;
        hide-on-clear = false;
        hide-on-action = true;
        script-fail-notify = true;

        widgets = [
          "label"
          "buttons-grid"
          "volume"
          "mpris"
          "dnd"
          "title"
          "notifications"
        ];

        widget-config = {
          title = {
            text = "Notifications";
            clear-all-button = true;
            button-text = "Clear all";
          };
          label = {
            max-lines = 1;
            text = "";
          };
          mpris = {
            image-size = 96;
            show-album-art = "when-available";
            loop-carousel = false;
          };
          volume = {
            label = "󰕾";
            show-per-app = true;
            expand-button-label = "󰘕";
            collapse-button-label = "󰘖";
            icon-size = 24;
            show-per-app-icon = true;
            show-per-app-label = false;
          };
          buttons-grid = {
            actions = [
              {
                label = "󰔎";
                command = "darkman toggle";
              }
              {
                label = "";
                command = "pactl set-source-mute @DEFAULT_SOURCE@ toggle";
                type = "toggle";
              }
              {
                label = "";
                active = true;
                command = "sh -c '[[ $SWAYNC_TOGGLE_STATE == true ]] && nmcli radio wifi on || nmcli radio wifi off'";
                update-command = "sh -c '[[ $(nmcli r wifi) == \"enabled\" ]] && echo true || echo false'";
              }
              {
                label = "󰝚";
                command = "~/AppImages/youtube-music.AppImage & swaync-client -t";
              }
              {
                label = "";
                command = "ghostty -e wlogout";
              }
            ];
          };
        };
      };
    in
    {
      config = lib.mkIf config.notifications.enable {

        environment.systemPackages = [
          pkgs.swaynotificationcenter
          (pkgs.writeShellScriptBin "swaync-reload" ''
            ${pkgs.swaynotificationcenter}/bin/swaync-client -R || true
          '')
        ];

        environment.etc."xdg/swaync/config.json".text = builtins.toJSON swayncConfig;
        environment.etc."xdg/swaync/style.css".text = swayncStyle;
      };
    };
}
