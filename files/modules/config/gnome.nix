{ pkgs, ... }:
{
  # Windowing system config
  services.xserver = {
    enable = true;
    xkb.layout = "us";
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    excludePackages = (with pkgs; [
      xterm
    ]);
  };

  environment = {
    systemPackages = with pkgs; [
      candy-icons
      dracula-theme
      gnome-tweaks
      onagre
      pop-launcher
      sweet-folders
    ] ++ (with pkgs.gnomeExtensions; [
      blur-my-shell
      bluetooth-quick-connect
      dash-to-dock
      ddterm
      gsconnect
      just-perfection
      logo-menu
      places-status-indicator
      privacy-settings-menu
      quake-terminal
      quick-settings-tweaker
      space-bar
      tiling-shell
      vitals
    ]);

    gnome.excludePackages = with pkgs; [
      epiphany # web browser
      evince # document viewer
      geary # email reader
      gnome-connections
      gnome-console
      gnome-music
      gnome-tour
      gnome-weather
      # seahorse # password manager
      xterm
      yelp
    ];
  };

  # GSConnect
  programs.kdeconnect = {
    enable = true;
    package = pkgs.gnomeExtensions.gsconnect;
  };
}
