{ pkgs, ... }:
{
  home.packages = with pkgs; [
    mako
    rofi-wayland
  ];
}
