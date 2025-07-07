{ pkgs, ... }:
{
  home.packages = with pkgs; [
    dbeaver-bin
    mysql-workbench
    sqlite
  ];
}
