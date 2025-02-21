{ pkgs, ... }:
{
  environment = {
    systemPackages = with pkgs; [
      brightnessctl
      file-roller # archive manager
      gnome-calculator
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
  services.blueman.enable = true;
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };


  programs = {
    hyprland = {
      enable = true;
      withUWSM = true;
      xwayland.enable = true;
    };
  };

  # Extend file-explorer functionality
  services = {
    gvfs.enable = true; # Mount, trash, and other functionalities
    tumbler.enable = true; # Thumbnail support for images
  };

  # Enable security services
  services.gnome.gnome-keyring.enable = true;
  security = {
    pam.services = {
      hyprlock = {};
      gdm.enableGnomeKeyring = true;
    };
    polkit.enable = true;
  };

  # Call dbus-update-activation-environment on login
  services.xserver.updateDbusEnvironment = true;

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
  };
}
