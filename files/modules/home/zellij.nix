{ ... } :
{
  programs.zellij = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      theme = "dracula";
      pane_frames = false;
      show_startup_tips = false;
      # default_layout = "compact";
      keybinds = {
        unbind = [
          "Ctrl o"
          "Ctrl h"
        ];

        move = {
          "bind \"Ctrl m\"" = { SwitchToMode = "Normal"; };
        };

        session = {
          "bind \"Ctrl e\"" = { SwitchToMode = "Normal"; };
        };

        "shared_except \"move\" \"locked\"" = {
          "bind \"Ctrl m\"" = { SwitchToMode = "Move"; };
        };

        "shared_except \"session\" \"locked\"" = {
          "bind \"Ctrl e\"" = { SwitchToMode = "Session"; };
        };
      };
    };
  };
}
