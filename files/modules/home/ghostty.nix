{ ... }:
{
  programs.ghostty = {
    enable = true;
    enableFishIntegration = true;
    installVimSyntax = true;
    settings = {
      theme = "Dracula";
      "font-family" = "JetBrainsMono Nerd Font";
      "font-size" = "11";
    };
  };
}
