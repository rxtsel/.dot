{
  services.swaync = {
    enable = true;

    settings = {
      positionX = "right";
      positionY = "top";
      cssPriority = "user";
      control-center-width = 480;
      control-center-height = 860;
      control-center-margin-top = 8;
      control-center-margin-bottom = 0;
      control-center-margin-right = 8;
      control-center-margin-left = 0;
      notification-window-width = 400;
      notification-icon-size = 48;
      notification-body-image-height = 160;
      notification-body-image-width = 200;
      timeout = 10;
      timeout-low = 2;
      timeout-critical = 6;
      fit-to-screen = false;
      keyboard-shortcuts = true;
      image-visibility = "when-available";
      transition-time = 200;
      hide-on-clear = false;
      hide-on-action = false;
      script-fail-notify = true;

      widgets =
        [ "label" "buttons-grid" "volume" "mpris" "title" "notifications" ];

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
          image-radius = 12;
        };
        volume = { label = "󰕾"; };
        buttons-grid = {
          actions = [
            {
              label = "";
              command = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
              type = "toggle";
              active = false;
            }
            {
              label = "";
              command = "pactl set-source-mute @DEFAULT_SOURCE@ toggle";
              type = "toggle";
            }
            {
              label = "";
              active = true;
              command =
                "sh -c '[[ $SWAYNC_TOGGLE_STATE == true ]] && nmcli radio wifi on || nmcli radio wifi off'";
              update-command =
                "sh -c '[[ $(nmcli r wifi) == \"enabled\" ]] && echo true || echo false'";
            }
            {
              label = "";
              command = "swaync-client -d";
              type = "toggle";
            }
            {
              label = "";
              command = "ghostty -e bluetui";
            }
            {
              label = "󰝚";
              command = "chromium --app=https://music.apple.com/co";
            }
            {
              label = "";
              command = "ghostty -e wlogout";
            }
          ];
        };
      };
    };

    style = ''
      @define-color text #839395;
      @define-color background #001419;
      @define-color background-alt #001419;
      @define-color selected #268bd3;
      @define-color selected-alt #002c38;
      @define-color urgent #db302d;

      /* NOTIFICATIONS ------------------------------------------------------------------------ */

      * {
        color: @text;

        all: unset;
        font-size: 16px;
        font-family: "Noto Sans", sans-serif;
        transition: 200ms;
      }

      .notification-row {
        outline: none;
        margin: 0;
        padding: 0px;
      }

      .floating-notifications.background .notification-row .notification-background {
        background: alpha(@background, 0.5);
        box-shadow:
          0 0px 2px 0px rgba(0, 0, 0, 0.25),
          0 0px 9px 0px rgba(0, 0, 0, 0.2);
        border: 1px solid @background;
        border-radius: 16px;
        padding: 12px;
        margin: 12px 12px 0 0;
      }

      .image {
        margin: 10px 20px 10px 0px;
      }

      .summary {
        font-weight: 800;
        font-size: 1rem;
      }

      .body {
        font-size: 1rem;
      }

      .floating-notifications.background .notification-row .notification-background .close-button {
        padding: 2px;
        border-radius: 999999px;
        background-color: transparent;
        font-size: 10px;
        margin-right: -6px;
        margin-top: -6px;
      }

      .floating-notifications.background .notification-row .notification-background .close-button:hover {
        background-color: alpha(@background, 0.6);
      }

      .floating-notifications.background .notification-row .notification-background .close-button:active {
        background-color: @selected-alt;
      }

      .notification.critical progress {
        background-color: @selected-alt;
      }

      .notification.low progress,
      .notification.normal progress {
        background-color: @selected-alt;
      }

      /* CONTROL CENTER ------------------------------------------------------------------------ */

      /* Avoid 'annoying' backgroud */
      .blank-window {
        background: transparent;
      }

      .control-center {
        background: alpha(@background, 0.55);
        border-radius: 30px;
        border: 1px solid @background;
        box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.6);
        padding: 10px 30px;
      }

      /* Notifications  */
      .control-center .notification-row .notification-background,
      .control-center .notification-row .notification-background .notification.critical {
        background: @background-alt;
        border-radius: 16px;
        padding: 12px;
        margin: 12px 20px 0 0;
      }

      .control-center .notification-row .notification-background .notification.critical {
        color: @urgent;
      }

      .control-center .notification-row .notification-background .notification .notification-content {
        padding: 12px;
      }

      .control-center .notification-row .notification-background .notification>*:last-child>* {
        min-height: 3.4em;
      }

      .control-center .notification-row .notification-background .notification>*:last-child>* .notification-action {
        background: alpha(@selected, 0.2);
        color: @text;
        border-radius: 12px;
        margin: 6px;
      }

      .control-center .notification-row .notification-background .notification>*:last-child>* .notification-action:hover {
        background-color: alpha(@background, 0.6);
      }

      .control-center .notification-row .notification-background .notification>*:last-child>* .notification-action:active {
        background-color: alpha(@background, 0.6);
      }

      .control-center .notification-row .notification-background .close-button {
        padding: 2px;
        border-radius: 999999px;
        background-color: transparent;
        font-size: 10px;
        margin-right: -6px;
        margin-top: -6px;
      }

      .control-center .notification-row .notification-background .close-button:hover {
        background-color: alpha(@background, 0.6);
        color: #ffffff;
      }

      .control-center .notification-row .notification-background .close-button:active {
        background-color: alpha(@background, 0.6);
        color: #ffffff;
      }

      progressbar,
      progress,
      trough {
        border-radius: 12px;
      }

      /* WIDGETS --------------------------------------------------------------------------- */

      /* Notification clear button */
      .widget-title {
        font-size: 1rem;
      }

      .widget-title button {
        background: @background;
        border-radius: 5px;
        padding: 3px 7px;
      }

      .widget-title button:hover {
        background-color: @selected;
      }

      .widget-title button:active {
        background-color: @background;
      }

      /* Buttons menu */
      .widget-buttons-grid {
        margin: 0 0 20px 0;
      }

      .widget-buttons-grid>flowbox>flowboxchild>button {
        padding: 10px 15px;
        background: @background;
        color: #ffffff;
        border-radius: 999px;
        transition: all 0.15s ease;
        margin: 0 5px 10px 5px;
      }

      .widget-buttons-grid>flowbox>flowboxchild>button label {
        font-size: 20px;
        margin: 0;
        padding: 0;
      }

      .widget-buttons-grid>flowbox>flowboxchild>button:hover {
        background: transparent;
      }

      .widget-buttons-grid>flowbox>flowboxchild>button.toggle:checked {
        background: transparent;
        color: @selected;
      }

      /* Music player */
      @define-color mpris-album-art-overlay rgba(0, 0, 0, 0.55);
      @define-color mpris-button-hover rgba(0, 0, 0, 0.50);

      .widget-mpris .widget-mpris-player {
        padding: 8px;
        padding: 16px;
        margin: 16px 0px;
        background-color: @mpris-album-art-overlay;
        border-radius: 12px;
        box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.75);
      }

      .widget-mpris .widget-mpris-player button:hover {
        /* The media player buttons (play, pause, next, etc...) */
        background: @background;
      }

      .widget-mpris .widget-mpris-player .widget-mpris-album-art {
        border-radius: 12px;
        box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.75);
      }

      .widget-mpris .widget-mpris-player .widget-mpris-title {
        font-weight: bold;
        font-size: 1.25rem;
      }

      .widget-mpris .widget-mpris-player .widget-mpris-subtitle {
        font-size: 1.1rem;
      }

      .widget-mpris .widget-mpris-player>box>button {
        /* Change player control buttons */
        padding: 8px;
        border-radius: 4px;
      }

      .widget-mpris .widget-mpris-player>box>button:hover {
        background-color: alpha(@background, 0.2);
      }

      /* Volume widget */
      .widget-volume {
        margin: 0 0 20px 0;
      }

      trough {
        border-radius: 20px;
        background: @background;
        margin-left: 20px;
        margin-right: 10px;
      }

      trough highlight {
        padding: 5px;
        background: @selected;
        border-radius: 20px;
        transition: all 0.15s ease;
      }

      trough highlight:hover {
        background: alpha(@selected, 0.8);
        border-radius: 20px;
      }

      trough slider {
        background: #ffffff;
        background: #ffffff;
        padding: 6px;
        border-radius: 12px;
      }
    '';
  };
}
