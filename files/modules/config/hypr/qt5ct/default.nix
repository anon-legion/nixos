{ pkgs, ... }:
{
  environment.systemPackages = with pkgs.libsForQt5; [
    qt5ct
  ];

  nixpkgs.config.qt5 = {
    enable = true;
    platformTheme = "qt5ct"; 
    # style = {
    #   name = "Utterly Nord Plasma";
    # };
  };
}
