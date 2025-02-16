{ pkgs, ... }:
{
  # Enable Gnome DE
  services.xserver.desktopManager.gnome.enable = true;

  environment = {
    systemPackages = with pkgs; [
      # candy-icons
      dracula-theme
      gnome-tweaks
      pop-launcher
      # sweet-folders
    ] ++ (with pkgs.gnomeExtensions; [
      blur-my-shell
      bluetooth-quick-connect
      dash-to-dock
      ddterm
      gsconnect
      just-perfection
      logo-menu
      places-status-indicator
      pop-shell
      privacy-settings-menu
      quake-terminal
      quick-settings-tweaker
      space-bar
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
