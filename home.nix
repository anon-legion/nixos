{ pkgs, ... }:

{
  home = {
    username = "thecomeback";
    homeDirectory = "/home/thecomeback";
    stateVersion = "24.05";
  };

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    dbeaver-bin
    devbox
    discord
    docker
    dotnet-sdk_8
    ferdium
    google-chrome
    hoppscotch
    httpie
    jetbrains.rider
    keepassxc
    kleopatra
    lazydocker
    lua
    nodejs
    nodePackages_latest.pnpm
    obsidian
    picard
    pinentry-gnome3
    qbittorrent
    spotify
    sqlite
    telegram-desktop
    tor-browser
    vscode
  ];

  home = {
    sessionPath = [
      "$HOME/.local/share/nvim/mason/bin"
      "$HOME/.dotnet/tools"
      "${pkgs.omnisharp-roslyn}"
    ];
    sessionVariables = {
      DOTNET_ROOT = "${pkgs.dotnet-sdk_8}";
      EDITOR = "nvim";
      #XCURSOR_SIZE = 24;
    };
  };

  gtk = {
    enable = true;
    font = {
      name = "FiraCode Nerd Font";
    };
  };

  # CLI
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

  # programs.nixvim = {
  #   enable = true;
  #   # colorschemes.dracula-nvim.enable = true;
  #   options = {
  #     number = true;
  #     relativeNumber = true;
  #     shiftWidth = 2;
  #   };
  #   plugins = {
  #     lualine.enable = true;
  #
  #     cmp = {
  #       enable = true;
  #       autoEnableSources = true;
  #       settings.sources = [
  #         { name = "nvim_lsp"; }
  #         { name = "path"; }
  #         { name = "buffer"; }
  #       ];
  #     };
  #     lsp = {
  #       enable = true;
  #       servers = {
  #         lua_ls.enable = true;
  #         nixd.enable = true;
  #         omnisharp.enable = true;
  #         ts_ls.enable = true;
  #       };
  #     };
  #   };
  # };

  # Neovim
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-unwrapped;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    withNodeJs = true;
    withPython3 = true;

    extraPackages = with pkgs; [
      bash-language-server
      csharpier
      lua-language-server
      markdownlint-cli
      nixd
      omnisharp-roslyn
      # roslyn-ls
      nodePackages.eslint
      nodePackages.prettier
      stylua
      typescript-language-server
      vscode-langservers-extracted
      yaml-language-server
    ];
  };

  programs.gpg = {
    enable = true;
  };

  services.gpg-agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-all;
  };

  xdg.configFile = {
    nvim = {
      enable = false;
      source = ./files/nvim;
      recursive = true;
    };
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
