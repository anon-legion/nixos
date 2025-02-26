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
      gnome-bluetooth
      gnome-calculator
      gnome-calendar
      gnome-control-center
      gnome-remote-desktop
      gnome-text-editor
      gst_all_1.gstreamer # a/v properties
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

  services = {
    # Bluetooth client
    blueman.enable = true;

    # Enable gnome services used by hyprland
    gnome = {
      gnome-keyring.enable = true;
      gnome-remote-desktop.enable = true;
    };
    udev.packages = [ pkgs.gnome-settings-daemon ];

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
