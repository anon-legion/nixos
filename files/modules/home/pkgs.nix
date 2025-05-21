{ pkgs, ... }:
{
  home.packages = with pkgs; [
    bruno
    dbeaver-bin
    discord
    dotnet-sdk_8
    ferdium
    google-chrome
    jetbrains.rider
    keepassxc
    obsidian
    picard
    pinentry-gnome3
    postman
    pavucontrol
    pulseaudio
    qbittorrent
    spotify
    sqlite
    telegram-desktop
    tor-browser
  ] ++ (with pkgs.kdePackages; [
    kleopatra
  ]);
}
