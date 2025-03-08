{ pkgs, ... }:
{
  imports = [
    ./overlays
  ];

  programs = {
    hyprland = {
      enable = true;
      withUWSM = true;
      xwayland.enable = true;
    };

    # Store Gnome based application settings
    dconf.enable = true;
  };

  environment = {
    systemPackages = with pkgs; [
      brightnessctl
      file-roller # archive manager
      gnome-calculator
      gnome-calendar
      gnome-online-accounts-gtk
      gnome-remote-desktop
      gnome-system-monitor
      gnome-text-editor
      hypridle
      hyprlock
      hyprpaper
      hyprpicker
      hyprshot
      kanshi
      libheif # HEIC image preview
      libheif.out # HEIC image preview
      loupe # image viewer
      nautilus # file manager
      networkmanagerapplet
      overskride
      rofi-wayland
      totem # video player
      seahorse # keyring manager front-end
      swaynotificationcenter
      swappy
      waybar
    ];

    sessionVariables = {
      NIXOS_OZONE_WL = "1";
      HYPRSHOT_DIR = "$HOME/Pictures/Screenshots/";
    };

    # HEIC image preview
    pathsToLink = [ "share/thumbnailers" ];
  };

  # Enable bluetooth support
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  # Ports used by kdeconnect
  networking.firewall = rec {
    allowedTCPPortRanges = [ { from = 1714; to = 1764; } ];
    allowedUDPPortRanges = allowedTCPPortRanges;
  };

  services = {
    # Enable gnome services used by hyprland
    gnome = {
      gnome-keyring.enable = true;
      gnome-online-accounts.enable = true;
      gnome-remote-desktop.enable = true;
    };
    udev.packages = [ pkgs.gnome-settings-daemon ];

    greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --remember --remember-session --cmd Hyprland";
          user = "greeter";
        };
      };
    };

    # Extend file-explorer functionality
    gvfs.enable = true; # Mount, trash, and other functionalities
    tumbler.enable = true; # Thumbnail support for images

    # Call dbus-update-activation-environment on login
    xserver.updateDbusEnvironment = true;
  };

  security = {
    pam.services = {
      hyprlock = {};
      gdm.enableGnomeKeyring = true;
    };
    polkit.enable = true;
  };

  systemd.services.greetd.serviceConfig = {
    Type = "idle";
    StandardInput = "tty";
    StandardOutput = "tty";
    StandardError = "journal"; # Without this errors will spam on screen
    # Without these bootlogs will spam on screen
    TTYReset = true;
    TTYVHangup = true;
    TTYVTDisallocate = true;
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];

    config = {
      common = {
        default = ["gtk" "hyprland"];
      };
    };
  };
}
