{ pkgs, ... }:

{
  home = {
    username = "thecomeback";
    homeDirectory = "/home/thecomeback";
    stateVersion = "24.05";
  };

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    bruno
    dbeaver-bin
    devbox
    discord
    docker
    dotnet-sdk_8
    ferdium
    hoppscotch
    jetbrains.rider
    keepassxc
    kdePackages.kleopatra
    lua
    nodejs
    nodePackages_latest.pnpm
    obsidian
    qbittorrent
    spotify
    station
    telegram-desktop
    tor-browser
    vscode
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
  };

  home = {
    sessionPath = [
      "$HOME/.local/share/nvim/mason/bin"
      "$HOME/.dotnet/tools"
    ];
    sessionVariables = {
      DOTNET_ROOT = "${pkgs.dotnet-sdk_8}";
      EDITOR = "nvim";
      #XCURSOR_SIZE = "24";
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
    atuin = {
      enable = false;
      enableFishIntegration = false;
      flags = [ "--disable-up-arrow" ];
      settings = {
        common_prefix = [
          ".."
          "cd"
          "ff"
          "g"
          "ll"
          "lla"
          "sudo"
          "z"
        ];
        enter_accept = false;
        inline_height = 30;
        invert = true;
        store_failed = false;
      };
    };
    #eza.enable = true;
    fish = {
      enable = true;
      interactiveShellInit = ''
        set fish_greeting # Disable greeting
      '';
    };
    keychain = {
      enable = true;
      enableFishIntegration = true;
    };
    tmux = {
      enable = true;
      clock24 = true;
      plugins = with pkgs.tmuxPlugins; [
        sensible
        yank
        {
          plugin = dracula;
          extraConfig = ''
            set -g @dracula-show-battery false
            set -g @dracula-battery-label "🔋"
            set -g @dracula-show-empty-plugins false
            set -g @dracula-show-fahrenheit false
            set -g @dracula-show-left-icon session
            set -g @dracula-show-powerline true
            set -g @dracula-refresh-rate 10
            set -g @dracula-network-bandwidth wlp2s0
            set -g @dracula-network-bandwidth-interval 0
            set -g @dracula-network-bandwidth-show-interface true
            set -g @dracula-ping-server "google.com"
            set -g @dracula-ping-rate 5
          '';
        }
      ];

      extraConfig = ''
        set -g mouse on
      '';
    };
    #yazi = { # terminal file manager
    #  enable = true;
    #  enableNushellIntegration = true;
    #};
    zoxide = {
      enable = true;
      enableFishIntegration = true;
    };
  };

  # Neovim
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-unwrapped;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    withNodeJs = true;
    withPython3 = true;
    #plugins = with pkgs.vimPlugins; [
    #  LazyVim
    #];

    extraPackages = with pkgs; [
      bash-language-server
      lua-language-server
      markdownlint-cli
      netcoredbg
      nixd
      nodePackages.eslint
      nodePackages.prettier
      #omnisharp-roslyn
      stylua
      typescript-language-server
      vscode-langservers-extracted
      yaml-language-server
    ];
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
