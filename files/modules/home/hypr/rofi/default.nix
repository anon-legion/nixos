{ pkgs, ... }:
{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    plugins = with pkgs; [
      (rofi-calc.override { rofi-unwrapped = rofi-wayland-unwrapped; })
    ];
  };
}
