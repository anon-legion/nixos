{ pkgs, ... }:
{
  environment = {
    systemPackages = with pkgs; [
      mako
      rofi-wayland
    ];
  };

  security.polkit.enable = true;
}
