{ ... }:
{
  programs.zed-editor = {
    enable = true;
    userSettings = {
      features = {
        copilot = true;
      };
      telemetry = {
        metrics = false;
      };
      vim_mode = false;
    };
  };
}
