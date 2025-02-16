{ pkgs, ... }:
{
  environment = {
    systemPackages = with pkgs; [
      kitty
      file-roller # archive manager
      gnome-calculator
      hypridle
      hyprlock
      hyprpaper
      hyprpicker
      hyprshot
      loupe # image viewer
      rofi-wayland
      totem # video player
      seahorse # keyring manager front-end
      swaynotificationcenter
      waybar
    ];

    sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };
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

    thunar.enable = true;
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
