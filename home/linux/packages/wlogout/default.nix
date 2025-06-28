{
  programs.wlogout = {
    enable = true;

    layout = [
      {
        label = "lock";
        action = "loginctl lock-session";
        text = "Lock";
        keybind = "l";
      }
      {
        label = "hibernate";
        action = "systemctl hibernate";
        text = "Hibernate";
        keybind = "h";
      }
      {
        label = "logout";
        action = "loginctl terminate-user $USER";
        text = "Logout";
        keybind = "e";
      }
      {
        label = "shutdown";
        action = "systemctl poweroff";
        text = "Shutdown";
        keybind = "s";
      }
      {
        label = "suspend";
        action = "systemctl suspend";
        text = "Suspend";
        keybind = "u";
      }
      {
        label = "reboot";
        action = "systemctl reboot";
        text = "Reboot";
        keybind = "r";
      }
    ];

    # TODO: User vars for username
    style = ''
      @define-color background #001419;
      @define-color selected #637981;

      * {
        background-image: none;
        box-shadow: none;
      }

      window {
        background-color: alpha(@background, 0.8);
      }

      button {
        border-radius: 30px;
        border-color: black;
        text-decoration-color: #FFFFFF;
        color: #FFFFFF;
        background-color: transparent;
        border-style: solid;
        border-width: 1px;
        background-repeat: no-repeat;
        background-position: center;
        background-size: 25%;
      }

      button:focus,
      button:active,
      button:hover {
        background-color: @selected;
        outline-style: none;
      }

      #lock {
        background-image: image(url("/home/rxtsel/.dots/home/linux/packages/wlogout/icons/lock.png"),
            url("/usr/share/wlogout/icons/lock.png"),
            url("/usr/local/share/wlogout/icons/lock.png"));
      }

      #logout {
        background-image: image(url("/home/rxtsel/.dots/home/linux/packages/wlogout/icons/logout.png"),
            url("/usr/share/wlogout/icons/logout.png"),
            url("/usr/local/share/wlogout/icons/logout.png"));
      }

      #suspend {
        background-image: image(url("/home/rxtsel/.dots/home/linux/packages/wlogout/icons/suspend.png"),
            url("/usr/share/wlogout/icons/suspend.png"),
            url("/usr/local/share/wlogout/icons/suspend.png"));
      }

      #hibernate {
        background-image: image(url("/home/rxtsel/.dots/home/linux/packages/wlogout/icons/hibernate.png"),
            url("/usr/share/wlogout/icons/hibernate.png"),
            url("/usr/local/share/wlogout/icons/hibernate.png"));
      }

      #shutdown {
        background-image: image(url("/home/rxtsel/.dots/home/linux/packages/wlogout/icons/shutdown.png"),
            url("/usr/share/wlogout/icons/shutdown.png"),
            url("/usr/local/share/wlogout/icons/shutdown.png"));
      }

      #reboot {
        background-image: image(url("/home/rxtsel/.dots/home/linux/packages/wlogout/icons/reboot.png"),
            url("/usr/share/wlogout/icons/reboot.png"),
            url("/usr/local/share/wlogout/icons/reboot.png"));
      }
    '';
  };
}
