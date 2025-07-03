{ pkgs, ... }:
{
  home.packages = with pkgs; [
    bruno
    dbeaver-bin
    discord
    ferdium
    google-chrome
    keepassxc
    obsidian
    picard
    pinentry-gnome3
    postman
    openfortivpn
    pavucontrol
    pulseaudio
    qbittorrent
    spotify
    sqlite
    telegram-desktop
    tor-browser
    zoom-us
  ] ++ (with pkgs.kdePackages; [
    kleopatra
  ]);
}
