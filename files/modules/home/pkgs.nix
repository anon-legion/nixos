{ pkgs, ... }:
{
  home.packages = with pkgs; [
    dbeaver-bin
    devbox
    discord
    docker
    dotnet-sdk_8
    ferdium
    google-chrome
    hoppscotch
    jetbrains.rider
    keepassxc
    lazydocker
    lua
    nodejs
    nodePackages_latest.pnpm
    obsidian
    picard
    pinentry-gnome3
    openfortivpn
    pavucontrol
    pulseaudio
    qbittorrent
    spotify
    sqlite
    telegram-desktop
    tor-browser
    vscode
  ] ++ (with pkgs.kdePackages; [
    kleopatra
  ]);
}
