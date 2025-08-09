{ pkgs, ... }:
{
  programs.bun.enable = true;

  home = {
    sessionPath = [
      "$HOME/.npm-global"
      "$HOME/.cache/.bun/bin"
      "$PNPM_HOME"
      "$PNPM_HOME/global"
    ];

    sessionVariables = {
      PNPM_HOME = "$HOME/.local/share/pnpm";
    };

    packages = with pkgs; [
      nodejs
      pnpm
      jetbrains.webstorm
    ];
  };
}
