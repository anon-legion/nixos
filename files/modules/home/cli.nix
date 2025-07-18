{ pkgs, ... }:
{
  programs = {
    btop = {
      enable = true;
      settings = {
        color_theme = "dracula";
        theme_background = false;
        vim_keys = true;
      };
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    fish = {
      enable = true;
      interactiveShellInit = ''
        set fish_greeting # Disable greeting

        function rdr --wraps=rider
          command rider $argv > /dev/null 2>&1 &
          disown
        end
      '';
    };

    keychain = {
      enable = true;
      enableFishIntegration = true;
    };

    ripgrep = {
      enable = true;
      arguments = ["--smart-case"];
    };

    tmux = {
      enable = true;
      clock24 = true;
      keyMode = "vi";
      prefix = "C-space";
      plugins = with pkgs.tmuxPlugins; [
        sensible
        yank
        {
          plugin = dracula;
          extraConfig = ''
            set -g @dracula-plugins "network-ping"
            set -g @dracula-show-empty-plugins false
            set -g @dracula-show-fahrenheit false
            set -g @dracula-show-left-icon session
            set -g @dracula-show-powerline true
            set -g @dracula-refresh-rate 10
            set -g @dracula-ping-server "google.com"
            set -g @dracula-ping-rate 5
          '';
        }
      ];
      extraConfig = ''
        bind-key -T copy-mode-vi v send-keys -X begin-selection
        bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
        set -g mouse on
      '';
    };

    yt-dlp.enable = true;

    zoxide = {
      enable = true;
      enableFishIntegration = true;
    };
  };

  home.packages = with pkgs; [
    cloc
    devbox
    lazydocker
    lua
    openfortivpn
    tdf
    tlrc
    tokei
    xh
    wget
  ];
}
