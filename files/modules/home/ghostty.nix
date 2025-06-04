{ ... }:
{
  programs.ghostty = {
    enable = true;
    enableFishIntegration = true;
    installVimSyntax = true;
    settings = {
      theme = "Dracula";
      maximize = "true";
      "cursor-style" = "block";
      "shell-integration-features" = "no-cursor"; # forces shell integration to use cursor style defined in settings
      "font-family" = "JetBrainsMono Nerd Font";
      "font-size" = "11";
    };
  };
}
