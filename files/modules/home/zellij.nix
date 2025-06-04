{ ... } :
{
  programs.zellij = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      theme = "dracula";
      pane_frames = false;
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

  home.file.".config/zellij/themes/dracula.kdl".source = ../../zellij/dracula.kdl;
}
