{ pkgs, ... }:
{
  environment = {
    systemPackages = with pkgs; [
      bat
      btop
      candy-icons
      dracula-theme
      gnome-tweaks
      gthumb
      eza
      fastfetch
      fd
      fishPlugins.autopair
      fishPlugins.bass
      fishPlugins.fzf-fish
      fishPlugins.sponge
      fishPlugins.tide
      fzf
      gcc
      inkscape-with-extensions
      lazygit
      libsecret
      logitech-udev-rules
      lollypop
      lunarvim
      menulibre
      onlyoffice-desktopeditors
      openssh
      openssl
      p7zip
      pop-launcher
      rofi-wayland
      sweet-folders
      ripgrep
      tlp
      tlrc # tldr in rust
      tmux
      unzip
      wget
      wl-clipboard
      xh
      zoxide
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
}
