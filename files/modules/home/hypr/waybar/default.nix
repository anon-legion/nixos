{...}:
{
  # Install and configure waybar via home-manager module
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        exclusive = true;
        passthrough = false;
        fixed-center = true;
        ipc = true;
        margin-top = 3;
        margin-left = 4;
        margin-right = 4;

        modules-left = [
          "battery"
          "cpu"
          "memory"
          "temperature"
          "network"
        ];

        modules-center = [
          "hyprland/workspaces"
          "clock"
          "disk"
        ];

        modules-right = [
          "privacy"
          "tray"
          "bluetooth"
          "pulseaudio"
          "backlight"
          "custom/notification"
          "custom/powerctrl"
        ];

        backlight = {
          interval = 3;
          align = 0;
          rotate = 0;
          format = "{icon} {percent}%";
          format-icons = ["󰃞" "󰃟" "󰃝" "󰃠"];
          icon-size = 9;
          on-scroll-up = "brightnessctl set +5%";
          on-scroll-down = "brightnessctl set 5%-";
          smooth-scrolling-threshold = 1;
          tooltip = false;
        };

        battery = {
          interval = 3;
          align = 0;
          rotate = 0;
          full-at = 100;
          design-capacity = false;
          states = {
            good = 95;
            warning = 30;
            critical = 20;
          };
          format = "{icon} {capacity}% 󰔟 {time} 󱐌 {power}w";
          format-charging = "󰂄 {capacity}% 󰔟 {time} 󱐌 {power}w";
          format-plugged = "󱞜 {capacity}% 󰔟 󰛤  󱐌 {power}w";
          format-full = "{icon} {capacity}% 󰔟 {time} 󱐌 {power}w";
          format-icons = {
            default = [
              "󰁻"
              "󰁽"
              "󰁿"
              "󰂁"
              "󰁹"
            ];
          };
          format-time = "{H}:{m}";
        };

        bluetooth = {
          format = "";
          format-connected = " {num_connections}";
          tooltip-format = " {device_alias}";
          tooltip-format-connected = "{device_enumerate}";
          tooltip-format-enumerate-connected = "Name: {device_alias}\nBattery: {device_battery_percentage}%";
          on-click = "overskride";
        };

        clock = {
          format = "{:%b %d %H:%M}";
          on-click = "gnome-calendar";
          timezone = "";
          tooltip = false;
        };

        cpu = {
          format = "󰍛 {usage}%";
          interval = 3;
        };

        "hyprland/workspaces" = {
          all-outputs = true;
          format = "{name}";
          on-click = "activate";
          show-special = false;
          sort-by-number = true;
        };

        disk = {
          unit = "TiB";
          format = " 󱘲 {percentage_used}%";
          tooltip-format = "Used: {used}\nFree: {free}\nTotal: {total}";
        };

        memory = {
          interval = 3;
          format = "󰾆 {used:0.1f}G";
          format-alt = "󰾆 {percentage}%";
          format-alt-click = "click";
          tooltip = true;
          tooltip-format = "{used:0.1f}GiB/{total:0.1f}GiB";
          on-click-right = "foot --title btop sh -c 'btop'";
        };

        network = {
          interval = 3;
          format = " 󰶣 {bandwidthUpBytes} 󰶡 {bandwidthDownBytes}";
          tooltip-format = "Interface: {ifname}\nIP: {ipaddr}\nGateway: {gwaddr}";
        };

        privacy = {
          icon-spacing = 18;
          icon-size = 16;
          transition-duration = 250;
          modules = [
            {
              type = "screenshare";
              tooltip = true;
              tooltip-icon-size = 18;
            }
            {
              type = "audio-out";
              tooltip = true;
              tooltip-icon-size = 18;
            }
            {
              type = "audio-in";
              tooltip = true;
              tooltip-icon-size = 18;
            }
          ];
        };

        pulseaudio = {
          format = "{icon} {volume}%";
          format-muted = "";
          format-icons = {
            default = [
              "󰕿"
              "󰖀"
              "󰕾"
            ];
          };
          on-click = "pavucontrol";
          on-scroll-up = "pamixer -i 5";
          on-scroll-down = "pamixer -d 5";
          scroll-step = 5;
          on-click-right = "pamixer -t";
          smooth-scrolling-threshold = 1;
          ignored-sinks = ["Easy Effects Sink"];
        };

        temperature = {
          interval = 10;
          tooltip = false;
          hwmon-path = "/sys/class/hwmon/hwmon1/temp1_input";
          critical-threshold = 82;
          format-critical = "󰈸 {temperatureC}°C";
          format = "{icon} {temperatureC}°C";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
          ];
        };

        tray = {
          spacing = 18;
        };

        "custom/notification" = {
          tooltip = false;
          format = "{icon}";
          format-icons = {
            notification = "<span foreground='red'><sup></sup></span>";
            none = "";
            dnd-notification = "<span foreground='red'><sup></sup></span>";
            dnd-none = "";
            inhibited-notification = "<span foreground='red'><sup></sup></span>";
            inhibited-none = "";
            dnd-inhibited-notification = "<span foreground='red'><sup></sup></span>";
            dnd-inhibited-none = "";
          };
          return-type = "json";
          exec-if = "which swaync-client";
          exec = "swaync-client -swb";
          on-click = "swaync-client -t -sw";
          on-click-right = "swaync-client -d -sw";
          escape = true;
        };

        "custom/powerctrl" = {
          tooltip = false;
          format = " <b>{icon}</b> ";
          format-icons = " ";
          on-click = "wlogout";
        };
      };
    };
    style = ''
      * {
        font-family: "JetBrainsMono Nerd Font";
        font-weight: bold;
        min-height: 0;
        font-size: 100%;
        font-feature-settings: '"zero", "ss01", "ss02", "ss03", "ss04", "ss05", "cv31"';
        padding: 0px;
        margin-top: 1px;
        margin-bottom: 1px;
      }

      window#waybar {
        background: rgba(0, 0, 0, 0);
      }

      window#waybar.hidden {
        opacity: 0.5;
      }

      tooltip {
        background: #1e1e2e;
        border-radius: 8px;
      }

      tooltip label {
        color: #cad3f5;
        margin-right: 5px;
        margin-left: 5px;
      }

      .modules-right,
      .modules-center,
      .modules-left {
        background-color: rgba(0, 0, 0, 0.6);
        border: 0px solid #b4befe;
        border-radius: 8px;
      }

      #workspaces button {
        padding: 2px;
        color: #6e6a86;
        margin-right: 5px;
      }

      #workspaces button.active {
        color: #dfdfdf;
        border-radius: 3px 3px 3px 3px;
      }

      #workspaces button.focused {
        color: #d8dee9;
      }

      #workspaces button.urgent {
        color: #ff79c6;
        border-radius: 8px;
      }

      #workspaces button:hover {
        color: #f8f8f2;
        border-radius: 3px;
      }

      #backlight,
      #battery,
      #bluetooth,
      #clock,
      #cpu,
      #custom-notification,
      #custom-recorder,
      #language,
      #memory,
      #tray,
      #pulseaudio,
      #temperature,
      #workspaces {
        color: #f8f8f2;
        padding: 0px 10px;
        border-radius: 8px;
      }

      #temperature.critical {
        background-color: #ff5555;
      }

      @keyframes blink {
        to {
          color: #000000;
        }
      }

      #taskbar button.active {
        background-color: #282a36;
      }

      #battery.critical:not(.charging) {
        color: #ff5555;
        animation-name: blink;
        animation-duration: 0.5s;
        animation-timing-function: linear;
        animation-iteration-count: infinite;
        animation-direction: alternate;
      }

      #custom-recorder {
        color: #ff5555;
      }
    '';
  };
}
