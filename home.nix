{ pkgs, ... }:

{
  home.username = "thecomeback";
  home.homeDirectory = "/home/thecomeback";

  home.stateVersion = "24.05";

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    devbox
    dotnet-sdk_8
    jetbrains.rider
    lunarvim
    nodejs
    nodePackages_latest.pnpm
    telegram-desktop
    vscode
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
  };

  home = {
    sessionPath = [
      "$HOME/.local/bin"
    ];
    sessionVariables = {
      EDITOR = "nvim";
    };
  };

  gtk = {
    enable = true;
    font = {
      name = "JetBrainsMono Nerd Font";
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
      csharpier
      lua-language-server
      markdownlint-cli
      netcoredbg
      nixd
      nodePackages.eslint
      nodePackages.prettier
      omnisharp-roslyn
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
