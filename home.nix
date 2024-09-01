{ config, pkgs, ... }:

{
  home.username = "thecomeback";
  home.homeDirectory = "/home/thecomeback";

  home.stateVersion = "24.05";

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    jetbrains.rider
    lunarvim
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
      LazyVim
    ];

    extraPackages = with pkgs; [
      lua-language-server
      markdownlint-cli
      nixd
      nodePackages.bash-language-server
      nodePackages.prettier
      #shellcheck
      stylua
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
