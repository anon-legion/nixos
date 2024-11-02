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

  # Starship shell prompt
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      aws.style = "bold #ffb86c";
      cmd_duration.style = "bold #f1fa8c";
      directory.style = "bold #50fa7b";
      hostname.style = "bold #ff5555";
      git_branch.style = "bold #ff79c6";
      git_status.style = "bold #ff5555";
      username = {
        format = "[$user]($style) on ";
        style_user = "bold #bd93f9";
      };
      character = {
        success_symbol = "[λ](bold #f8f8f2)";
        error_symbol = "[λ](bold #ff5555)";
      };
    };
  };

  # Allow home-manager to manage fish configs
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
      starship init fish | source
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
