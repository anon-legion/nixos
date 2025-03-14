{ config, lib, pkgs, ... }:
{
  imports = [
    ./cliphist
    ./kanshi
    ./misc/gtk
    ./misc/wallpaper
    ./misc/xdg
    ./rofi
    ./swaync
    ./waybar
    ./wlogout
  ];

  home = {
    # Consistent cursor theme across all applications.
    pointerCursor = {
      gtk.enable = true;
      x11.enable = true;
      package = pkgs.adwaita-icon-theme;
      name = "Adwaita";
      size = 24;
    };
  };

  services.kdeconnect = {
    enable = true;
    indicator = true;
  };

  xdg.configFile = {
    "swappy/config".text = ''
      [Default]
      save_dir=$HOME/Pictures/Screenshots/
      save_filename_format=%Y-%m-%d-%H%M%S_hyprshot.png
    '';
  };

  # Source hyprland config from the home-manager store
  xdg.configFile = {
    "hypr/hyprland.conf" = {
      source = ./hyprland.conf;
    };

    "hypr/hyprpaper.conf".text = ''
      splash = false
      preload = ${config.wallpaper}
      wallpaper = , ${config.wallpaper}
    '';

    "hypr/hypridle.conf".text = ''
      general {
        lock_cmd = pidof hyprlock || hyprlock
        before_sleep_cmd = loginctl lock-session
        after_sleep_cmd = hyprctl dispatch dpms on
      }

      listener {
        timeout = 150
        on-timeout = brightnessctl -s set 9
        on-resume = brightnessctl -r
      }

      listener {
        timeout = 300
        on-timeout = loginctl lock-session
      }

      listener {
        timeout = 330
        on-timeout = hyprctl dispatch dpms off
        on-resume = hyprctl dispatch dpms on
      }

      listener {
        timeout = 600
        on-timeout = systemctl suspend
      }
    '';

    "hypr/hyprlock.conf".text = ''
      auth {
        fingerprint:enabled = true
      }

      background {
        monitor =
        path = ${config.wallpaper} 
        blur_passes = 3
        contrast = 0.8916
        brightness = 0.8172
        vibrancy = 0.1696
        vibrancy_darkness = 0.0
      }

      general {
        no_fade_in = false
        grace = 0
        disable_loading_bar = true
      }

      input-field {
        monitor = eDP-1
        size = 500, 120
        outline_thickness = 2
        dots_size = 0.2 # Scale of input-field height, 0.2 - 0.8
        dots_spacing = 0.2 # Scale of dots' absolute size, 0.0 - 1.0
        dots_center = true
        outer_color = rgba(0, 0, 0, 0)
        inner_color = rgba(0, 0, 0, 0.5)
        font_color = rgb(200, 200, 200)
        fade_on_empty = false
        capslock_color = -1
        placeholder_text = <i><span foreground="##6272a4">Password</span></i>
        fail_text = <i>$FAIL <b>($ATTEMPTS)</b></i>
        hide_input = false
        position = 0, -120
        halign = center
        valign = center
      }

      label {
        monitor = eDP-1
        text = cmd[update:1000] echo "<span>$(date '+%A, %d %B')</span>"
        color = rgba(255, 255, 255, 0.8)
        font_size = 30
        font_family = JetBrains Mono Nerd Font Mono ExtraBold
        position = 0, -400
        halign = center
        valign = top
      }

      label {
        monitor = eDP-1
        text = cmd[update:1000] echo "<span>$(date '+%H:%M')</span>"
        color = rgba(255, 255, 255, 0.8)
        font_size = 240
        font_family = JetBrains Mono Nerd Font Mono ExtraBold
        position = 0, -400
        halign = center
        valign = top
      }
    '';
  };

  dconf.settings = {
    "org/blueman/general" = {
      "plugin-list" = lib.mkForce ["!StatusNotifierItem"];
    };

    "org/blueman/plugins/powermanager" = {
      "auto-power-on" = true;
    };

    "org/gnome/calculator" = {
      "accuracy" = 9;
      "angle-units" = "degrees";
      "base" = 10;
      "button-mode" = "basic";
      "number-format" = "automatic";
      "show-thousands" = false;
      "show-zeroes" = false;
      "source-currency" = "";
      "source-units" = "degree";
      "target-currency" = "";
      "target-units" = "radian";
      "window-maximized" = false;
    };

    "org/gnome/desktop/interface" = {
      "color-scheme" = "prefer-dark";
      "cursor-theme" = "Adwaita";
      "icon-theme" = "Tela-circle-dark";
    };

    "org/gnome/desktop/wm/preferences" = {
      "button-layout" = lib.mkForce "";
    };

    "org/gnome/nautilus/preferences" = {
      "default-folder-viewer" = "grid-view";
      "migrated-gtk-settings" = true;
      "search-filter-time-type" = "last_modified";
      "search-view" = "list-view";
    };

    "org/gnome/nm-applet" = {
      "disable-connected-notifications" = true;
      "disable-vpn-notifications" = true;
    };

    "org/gtk/gtk4/settings/file-chooser" = {
      "show-hidden" = false;
    };

    "org/gtk/settings/file-chooser" = {
      "date-format" = "regular";
      "location-mode" = "path-bar";
      "show-hidden" = false;
      "show-size-column" = true;
      "show-type-column" = true;
      "sort-column" = "name";
      "sort-directories-first" = true;
      "sort-order" = "ascending";
      "type-format" = "category";
      "view-type" = "list";
    };
  };
}
