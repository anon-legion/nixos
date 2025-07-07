{ pkgs, ... }:
{
  home = {
    sessionPath = [
      "$HOME/.npm-global"
      "$HOME/.local/bin/pnpm"
    ];
    packages = with pkgs; [
      nodejs
      pnpm
      jetbrains.webstorm
    ];
  };
}
