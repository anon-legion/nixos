{ pkgs, ... }:
{
  programs.zed-editor = {
    enable = true;
    package = pkgs.zed-editor-fhs;
    extensions = [
      "dracula"
      "html"
      "typescript"
    ];
    userSettings = {
      theme = "Dracula";
      features = {
        copilot = true;
      };
      telemetry = {
        metrics = false;
      };
      vim_mode = true;
    };
  };
}
