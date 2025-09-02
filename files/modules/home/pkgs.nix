{ pkgs, ... }:
{
  home.packages = with pkgs; [
    bruno
    discord
    ferdium
    google-chrome
    keepassxc
    krita
    obsidian
    picard
    pinentry-gnome3
    postman
    openfortivpn
    pavucontrol
    pulseaudio
    qbittorrent
    spotify
    telegram-desktop
    tor-browser
    zoom-us
  ] ++ (with pkgs.kdePackages; [
    kleopatra
  ]);


  programs = {
    obs-studio.enable = true;
  };
}
