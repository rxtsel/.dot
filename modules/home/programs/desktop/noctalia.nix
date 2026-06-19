{inputs, ...}: {
  flake.modules.homeManager.noctalia = {osConfig, ...}: let
    username = osConfig.preferences.user.name;
  in {
    imports = [
      inputs.noctalia.homeModules.default
    ];

    programs.noctalia = {
      enable = true;
      settings = {
        settingsVersion = 59;

        bar = {
          barType = "framed";
          position = "top";
          monitors = [];
          density = "compact";
          showOutline = false;
          showCapsule = false;
          capsuleOpacity = 1;
          capsuleColorKey = "none";
          widgetSpacing = 0;
          contentPadding = 0;
          fontScale = 1.1;
          enableExclusionZoneInset = true;
          backgroundOpacity = 0.8;
          useSeparateOpacity = false;
          marginVertical = 4;
          marginHorizontal = 4;
          frameThickness = 8;
          frameRadius = 12;
          outerCorners = true;
          hideOnOverview = true;
          displayMode = "always_visible";
          autoHideDelay = 500;
          autoShowDelay = 150;
          showOnWorkspaceSwitch = true;
          widgets = {
            start = ["workspaces"];
            center = ["audio_visualizer"];
            end = ["tray" "privacy" "clipboard" "network" "bluetooth" "volume" "battery" "clock" "notifications"];
            fontFamily = "SF Pro Display";
            marginEdge = 0;
            marginEnds = 0;
            padding = 4;
            radius = 0;
            radiusBottomLeft = -12;
            radiusBottomRight = -12;
            shadow = false;
            thickness = 24;
            left = [
              {
                id = "Workspace";
                characterCount = 2;
                colorizeIcons = false;
                emptyColor = "secondary";
                enableScrollWheel = true;
                focusedColor = "primary";
                followFocusedScreen = false;
                fontWeight = "bold";
                groupedBorderOpacity = 1;
                hideUnoccupied = false;
                iconScale = 0.8;
                labelMode = "none";
                occupiedColor = "secondary";
                pillSize = 0.4;
                showApplications = false;
                showApplicationsHover = false;
                showBadge = true;
                showLabelsOnlyWhenOccupied = false;
                unfocusedIconsOpacity = 1;
              }
            ];
            right = [
              {
                blacklist = [];
                chevronColor = "none";
                colorizeIcons = false;
                drawerEnabled = true;
                hidePassive = false;
                id = "Tray";
                pinned = [];
              }
              {
                id = "plugin:port-monitor";
                defaultSettings = {
                  hideSystemPorts = true;
                  hideWhenEmpty = true;
                  refreshInterval = 5;
                };
              }
              {
                displayMode = "onhover";
                iconColor = "none";
                id = "VPN";
                textColor = "none";
              }
              {
                displayMode = "onhover";
                iconColor = "none";
                id = "Bluetooth";
                textColor = "none";
              }
              {
                displayMode = "onhover";
                iconColor = "none";
                id = "Volume";
                middleClickCommand = "pwvucontrol || pavucontrol";
                textColor = "none";
              }
              {
                id = "Network";
                displayMode = "alwaysHide";
                iconColor = "none";
                textColor = "none";
              }
              {
                id = "Battery";
                alwaysShowPercentage = false;
                deviceNativePath = "__default__";
                displayMode = "graphic";
                hideIfIdle = false;
                hideIfNotDetected = true;
                showNoctaliaPerformance = false;
                showPowerProfiles = false;
                warningThreshold = 30;
              }
              {
                compactMode = false;
                diskPath = "/";
                iconColor = "none";
                id = "SystemMonitor";
                showCpuCores = false;
                showCpuFreq = false;
                showCpuTemp = true;
                showCpuUsage = true;
                showDiskAvailable = false;
                showDiskUsage = true;
                showDiskUsageAsPercent = false;
                showGpuTemp = false;
                showLoadAverage = false;
                showMemoryAsPercent = false;
                showMemoryUsage = true;
                showNetworkStats = false;
                showSwapUsage = false;
                textColor = "none";
                useMonospaceFont = true;
                usePadding = false;
              }
              {
                id = "Clock";
                clockColor = "none";
                customFont = "";
                formatHorizontal = "ddd, MMM dd, HH:mm";
                formatVertical = "HH mm";
                tooltipFormat = "HH:mm ddd, MMM dd";
                useCustomFont = false;
                useMonospacedFont = true;
                usePrimaryColor = true;
              }
              {
                id = "NotificationHistory";
                hideWhenZero = false;
                hideWhenZeroUnread = false;
                iconColor = "none";
                showUnreadBadge = true;
                unreadBadgeColor = "error";
              }
            ];
          };
          mouseWheelAction = "none";
          reverseScroll = false;
          mouseWheelWrap = true;
          middleClickAction = "none";
          middleClickFollowMouse = false;
          middleClickCommand = "";
          rightClickAction = "controlCenter";
          rightClickFollowMouse = true;
          rightClickCommand = "";
          screenOverrides = [];
        };

        general = {
          avatarImage = "/home/${username}/.face";
          dimmerOpacity = 0;
          showScreenCorners = false;
          forceBlackScreenCorners = false;
          scaleRatio = 1;
          radiusRatio = 1;
          iRadiusRatio = 1;
          boxRadiusRatio = 1;
          screenRadiusRatio = 1;
          animationSpeed = 1.5;
          animationDisabled = false;
          compactLockScreen = false;
          lockScreenAnimations = false;
          lockOnSuspend = true;
          showSessionButtonsOnLockScreen = true;
          showHibernateOnLockScreen = false;
          enableLockScreenMediaControls = false;
          enableShadows = false;
          enableBlurBehind = true;
          shadowDirection = "bottom_right";
          shadowOffsetX = 2;
          shadowOffsetY = 3;
          language = "";
          allowPanelsOnScreenWithoutBar = true;
          showChangelogOnStartup = false;
          telemetryEnabled = false;
          enableLockScreenCountdown = true;
          lockScreenCountdownDuration = 10000;
          autoStartAuth = false;
          allowPasswordWithFprintd = false;
          clockStyle = "custom";
          clockFormat = "hh\nmm";
          passwordChars = false;
          lockScreenMonitors = [];
          lockScreenBlur = 0;
          lockScreenTint = 0;
          keybinds = {
            keyUp = ["Up"];
            keyDown = ["Down"];
            keyLeft = ["Left"];
            keyRight = ["Right"];
            keyEnter = ["Return" "Enter"];
            keyEscape = ["Esc"];
            keyRemove = ["Del"];
          };
          reverseScroll = false;
          smoothScrollEnabled = true;
        };

        ui = {
          fontDefault = "SF Pro Display";
          fontFixed = "SF Mono";
          fontDefaultScale = 1;
          fontFixedScale = 1;
          tooltipsEnabled = true;
          scrollbarAlwaysVisible = false;
          boxBorderEnabled = false;
          panelBackgroundOpacity = 0.7;
          translucentWidgets = true;
          panelsAttachedToBar = true;
          settingsPanelMode = "attached";
          settingsPanelSideBarCardStyle = false;
        };

        location = {
          name = "Pasto, nariño";
          weatherEnabled = true;
          weatherShowEffects = true;
          weatherTaliaMascotAlways = false;
          useFahrenheit = false;
          use12hourFormat = false;
          showWeekNumberInCalendar = false;
          showCalendarEvents = true;
          showCalendarWeather = true;
          analogClockInCalendar = false;
          firstDayOfWeek = -1;
          hideWeatherTimezone = false;
          hideWeatherCityName = true;
          autoLocate = true;
        };

        calendar = {
          cards = [
            {
              enabled = true;
              id = "calendar-header-card";
            }
            {
              enabled = true;
              id = "calendar-month-card";
            }
            {
              enabled = true;
              id = "weather-card";
            }
          ];
        };

        wallpaper = {
          enabled = true;
          overviewEnabled = false;
          directory = "~/.dotfiles/assets/wallpapers";
          directoryLight = "~/.dotfiles/assets/wallpapers/light";
          directoryDark = "~/.dotfiles/assets/wallpapers/dark";
          showHiddenFiles = false;
          viewMode = "recursive";
          setWallpaperOnAllMonitors = true;
          fillMode = "crop";
          fillColor = "#000000";
          useSolidColor = false;
          solidColor = "#1a1a2e";
          automationEnabled = false;
          wallpaperChangeMode = "random";
          randomIntervalSec = 300;
          transitionDuration = 1500;
          transition = ["fade" "zoom"];
          skipStartupTransition = true;
          transitionEdgeSmoothness = 0.05;
          panelPosition = "top_center";
          hideWallpaperFilenames = false;
          useOriginalImages = false;
          overviewBlur = 0.4;
          overviewTint = 0.6;
          useWallhaven = false;
          wallhavenQuery = "";
          wallhavenSorting = "relevance";
          wallhavenOrder = "desc";
          wallhavenCategories = "100";
          wallhavenPurity = "100";
          wallhavenRatios = "16x9";
          wallhavenApiKey = "";
          wallhavenResolutionMode = "atleast";
          wallhavenResolutionWidth = "2560";
          wallhavenResolutionHeight = "1440";
          sortOrder = "name";
          favorites = [];
        };

        appLauncher = {
          enabled = false;
        };

        controlCenter = {
          position = "close_to_bar_button";
          diskPath = "/";
          shortcuts = {
            left = [
              {id = "Network";}
              {id = "Bluetooth";}
              {id = "WallpaperSelector";}
              {id = "NoctaliaPerformance";}
            ];
            right = [
              {id = "Notifications";}
              {id = "PowerProfile";}
              {id = "KeepAwake";}
              {id = "NightLight";}
            ];
          };
          cards = [
            {
              enabled = true;
              id = "profile-card";
            }
            {
              enabled = true;
              id = "shortcuts-card";
            }
            {
              enabled = true;
              id = "audio-card";
            }
            {
              enabled = true;
              id = "brightness-card";
            }
            {
              enabled = true;
              id = "weather-card";
            }
            {
              enabled = true;
              id = "media-sysmon-card";
            }
          ];
        };

        systemMonitor = {
          cpuWarningThreshold = 80;
          cpuCriticalThreshold = 90;
          tempWarningThreshold = 80;
          tempCriticalThreshold = 90;
          gpuWarningThreshold = 80;
          gpuCriticalThreshold = 90;
          memWarningThreshold = 80;
          memCriticalThreshold = 90;
          swapWarningThreshold = 80;
          swapCriticalThreshold = 90;
          diskWarningThreshold = 80;
          diskCriticalThreshold = 90;
          diskAvailWarningThreshold = 20;
          diskAvailCriticalThreshold = 10;
          batteryWarningThreshold = 20;
          batteryCriticalThreshold = 5;
          enableDgpuMonitoring = false;
          useCustomColors = false;
          warningColor = "";
          criticalColor = "";
          externalMonitor = "resources || missioncenter || jdsystemmonitor || corestats || system-monitoring-center || gnome-system-monitor || plasma-systemmonitor || mate-system-monitor || ukui-system-monitor || deepin-system-monitor || pantheon-system-monitor";
        };

        noctaliaPerformance = {
          disableWallpaper = true;
          disableDesktopWidgets = true;
        };

        dock = {
          enabled = false;
        };

        network = {
          bluetoothRssiPollingEnabled = false;
          bluetoothRssiPollIntervalMs = 60000;
          networkPanelView = "wifi";
          wifiDetailsViewMode = "grid";
          bluetoothDetailsViewMode = "grid";
          bluetoothHideUnnamedDevices = false;
          disableDiscoverability = false;
          bluetoothAutoConnect = true;
        };

        sessionMenu = {
          enableCountdown = true;
          countdownDuration = 6000;
          position = "center";
          showHeader = true;
          showKeybinds = true;
          largeButtonsStyle = true;
          largeButtonsLayout = "single-row";
          powerOptions = [
            {
              action = "lock";
              command = "";
              countdownEnabled = true;
              enabled = true;
              keybind = "1";
            }
            {
              action = "suspend";
              command = "";
              countdownEnabled = true;
              enabled = true;
              keybind = "2";
            }
            {
              action = "hibernate";
              command = "";
              countdownEnabled = true;
              enabled = true;
              keybind = "3";
            }
            {
              action = "reboot";
              command = "";
              countdownEnabled = true;
              enabled = true;
              keybind = "4";
            }
            {
              action = "logout";
              command = "";
              countdownEnabled = true;
              enabled = true;
              keybind = "5";
            }
            {
              action = "shutdown";
              command = "";
              countdownEnabled = true;
              enabled = true;
              keybind = "6";
            }
          ];
        };

        notifications = {
          enabled = true;
          enableMarkdown = false;
          density = "default";
          monitors = [];
          location = "top_right";
          overlayLayer = true;
          backgroundOpacity = 0.8;
          respectExpireTimeout = false;
          lowUrgencyDuration = 3;
          normalUrgencyDuration = 8;
          criticalUrgencyDuration = 15;
          clearDismissed = true;
          saveToHistory = {
            low = true;
            normal = true;
            critical = true;
          };
          sounds = {
            enabled = false;
          };
          enableMediaToast = false;
          enableKeyboardLayoutToast = true;
          enableBatteryToast = true;
        };

        osd = {
          enabled = true;
          location = "top_right";
          autoHideMs = 2000;
          overlayLayer = true;
          backgroundOpacity = 1;
          enabledTypes = [0 1 2];
          monitors = [];
        };

        audio = {
          volumeStep = 5;
          volumeOverdrive = false;
          spectrumFrameRate = 30;
          visualizerType = "linear";
          spectrumMirrored = true;
          mprisBlacklist = [];
          preferredPlayer = "";
          volumeFeedback = true;
          volumeFeedbackSoundFile = "";
        };

        brightness = {
          brightnessStep = 5;
          enforceMinimum = true;
          enableDdcSupport = osConfig.my.host.features.ddcci;
          enable_ddcutil = true;
          backlightDeviceMappings = [];
        };

        colorSchemes = {
          useWallpaperColors = true;
          predefinedScheme = "Monochrome";
          schedulingMode = "manual";
          manualSunrise = "06:30";
          manualSunset = "18:00";
          generationMethod = "monochrome";
          monitorForColors = "";
          syncGsettings = true;
        };

        templates = {
          activeTemplates = [
            {
              enabled = true;
              id = "btop";
            }
            {
              enabled = true;
              id = "cava";
            }
            {
              enabled = true;
              id = "niri";
            }
            {
              enabled = true;
              id = "yazi";
            }
            {
              enabled = true;
              id = "zenBrowser";
            }
            {
              enabled = true;
              id = "discord";
            }
            {
              enabled = true;
              id = "gtk";
            }
            {
              enabled = true;
              id = "qt";
            }
          ];
          enableUserTheming = false;
        };

        nightLight = {
          enabled = true;
          forced = false;
          autoSchedule = true;
          nightTemp = "4000";
          dayTemp = "6500";
          manualSunrise = "06:30";
          manualSunset = "18:30";
        };

        hooks = {
          started = "systemctl --user start desktop-theme-sync.service";
          theme_mode_changed = "systemctl --user start desktop-theme-sync.service";
        };

        idle = {
          enabled = false;
        };

        desktopWidgets = {
          enabled = false;
        };

        desktop_widgets = {
          enabled = false;
          schema_version = 2;
          widget_order = [];
          grid = {
            cell_size = 16;
            major_interval = 4;
            visible = true;
          };
          widget = {};
        };

        lockscreen_widgets = {
          enabled = true;
          schema_version = 2;
          widget_order = [
            "lockscreen-login-box@DP-1"
            "lockscreen-login-box@DP-2"
            "lockscreen-widget-0000000000000002"
            "lockscreen-widget-0000000000000001"
          ];
          grid = {
            cell_size = 16;
            major_interval = 4;
            visible = true;
          };
          widget = {
            "lockscreen-login-box@DP-1" = {
              box_height = 70.0;
              box_width = 400.0;
              cx = 1280.0;
              cy = 1321.0;
              output = "DP-1";
              rotation = 0.0;
              type = "login_box";
              settings = {
                background_color = "surface_variant";
                background_opacity = 0.88;
                background_radius = 12.0;
                input_opacity = 1.0;
                input_radius = 6.0;
                show_login_button = true;
              };
            };
            "lockscreen-login-box@DP-2" = {
              box_height = 70.0;
              box_width = 400.0;
              cx = 1280.0;
              cy = 1321.0;
              output = "DP-2";
              rotation = 0.0;
              type = "login_box";
              settings = {
                background_color = "surface_variant";
                background_opacity = 0.88;
                background_radius = 12.0;
                input_opacity = 1.0;
                input_radius = 6.0;
                show_login_button = true;
              };
            };
            "lockscreen-widget-0000000000000001" = {
              box_height = 336.0;
              box_width = 672.0;
              cx = 1280.0;
              cy = 168.0;
              output = "DP-1";
              rotation = 0.0;
              type = "clock";
              settings = {
                background = false;
                center_text = true;
                clock_style = "digital";
                font_family = "SF Pro Display";
                shadow = false;
              };
            };
            "lockscreen-widget-0000000000000002" = {
              box_height = 64.0;
              box_width = 272.0;
              cx = 1280.0;
              cy = 304.0;
              output = "DP-1";
              rotation = 0.0;
              type = "audio_visualizer";
              settings = {
                aspect_ratio = 2.5;
                background = false;
                bands = 32;
                show_when_idle = true;
              };
            };
          };
        };

        nightlight = {
          enabled = true;
        };

        plugin_settings."noctalia/screen_recorder" = {
          directory = "";
        };

        shell = {
          avatar_path = "/home/rxtsel/Pictures/logo.jpeg";
          clipboard_enabled = false;
          font_family = "SF Pro Display";
          polkit_agent = true;
          settings_show_advanced = true;
          panel = {
            clipboard_placement = "attached";
            launcher_categories = false;
            launcher_show_icons = false;
            launcher_sort_by_usage = false;
            open_near_click_clipboard = true;
            transparency_mode = "glass";
          };
          screen_corners = {
            enabled = true;
            size = 12;
          };
          screenshot = {
            directory = "/home/rxtsel/Pictures/screenshots";
          };
          shadow = {
            alpha = 0.0099999997764825821;
          };
        };

        control_center = {
          shortcuts = [
            {type = "wifi";}
            {type = "bluetooth";}
            {type = "nightlight";}
            {type = "notification";}
            {type = "dark_mode";}
            {type = "wallpaper";}
          ];
        };

        theme = {
          community_palette = "Solarized";
          mode = "auto";
          source = "wallpaper";
          wallpaper_scheme = "m3-monochrome";
        };

        widget = {
          clock = {
            format = "{:%a %d %b}, {:%H:%M}";
          };
          media = {
            hide_when_no_media = true;
          };
          network = {
            show_label = false;
          };
          privacy = {
            hide_inactive = true;
          };
          tray = {
            drawer = true;
          };
          volume = {
            show_label = false;
          };
          workspaces = {
            display = "none";
            hide_when_empty = true;
            pill_scale = 0.55;
          };
        };
      };
    };
  };
}
