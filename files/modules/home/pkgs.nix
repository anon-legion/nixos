{ pkgs, ... }:
{
  home.packages = with pkgs; [
    bruno
    cloc
    dbeaver-bin
    devbox
    discord
    docker
    dotnet-sdk_8
    ferdium
    google-chrome
    jetbrains.rider
    keepassxc
    lazydocker
    lua
    nodejs
    nodePackages_latest.pnpm
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
  ] ++ (with pkgs.kdePackages; [
    kleopatra
  ]);
}
