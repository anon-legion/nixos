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
    dotnet-sdk_8
    ferdium
    hoppscotch
    jetbrains.rider
    keepassxc
    kdePackages.kleopatra
    nodejs
    nodePackages_latest.pnpm
    obsidian
    qbittorrent
    spotify
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
      DOTNET_ROOT = "/nix/store/xbnpbibdqy8rivl28g613nh9vlpq0jrg-dotnet-sdk-8.0.401";
      EDITOR = "nvim";
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
    #atuin = {  # shell history
    #  enable = true;
    #  enableNushellIntegration = true;
    #};
    carapace = {
      enable = true;
      enableNushellIntegration = true;
    };
    eza = {
      enable = true;
      enableNushellIntegration = true;
    };
    keychain = {
      enable = true;
      enableNushellIntegration = true;
    };
    nushell = {
      enable = true;
      extraEnv = ''
        mkdir ~/.cache/starship
        starship init nu | save -f ~/.cache/starship/init.nu
      '';
      extraConfig = ''
        use ~/.cache/starship/init.nu
      '';
    };
    starship = {
      enable = true;
      enableNushellIntegration = true;
      settings = {
        format = ''
          [┌─][](bg:#030B16 fg:#7DF9AA)[  ](bg:#7DF9AA fg:#090c0c)[](fg:#7DF9AA bg:#1C3A5E)$time[](fg:#1C3A5E bg:#3B76F0)$directory[](fg:#3B76F0 bg:#FCF392)$git_branch$git_status$git_metrics[](fg:#FCF392 bg:#030B16)$line_break[└──]$character
        '';
        aws.style = "bold #ffb86c";
        cmd_duration.style = "bold #f1fa8c";
        directory.style = "bold #50fa7b";
        hostname.style = "bold #ff5555";
        git_branch.style = "bold #ff79c6";
        git_status.style = "bold #ff5555";
        username = {
          format = "[$user]($style) ";
          style_user = "bold #bd93f9";
        };
        character = {
          format = "$symbol ";
          vicmd_symbol = "[❮](bold green)";
          disabled = false;
          success_symbol = "[❯](bold green) ";
          error_symbol = "[❯](bold red) ";
        };
      };
    };
    #yazi = { # terminal file manager
    #  enable = true;
    #  enableNushellIntegration = true;
    #};
    zoxide = {
      enable = true;
      enableNushellIntegration = true;
    };
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
    '';
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
    plugins = with pkgs.vimPlugins; [
      conform-nvim
      LazyVim
      neotest-dotnet
      none-ls-nvim
      nvim-dap
      nvim-dap-ui
      nvim-dap-virtual-text
      omnisharp-extended-lsp-nvim
    ];

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
