{ config, pkgs, ... }:

let
  neovim_config = ../.config/nvim;
in
{
  home.username = "thecomeback";
  home.homeDirectory = "/home/thecomeback";

  home.stateVersion = "24.05";

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    jetbrains.rider
    #neovim
    telegram-desktop
    vscode
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    withNodeJs = true;
    withPython3 = true;
    plugins = with pkgs.vimPlugins; [
      LazyVim
    ];
  };

  xdg.configFile = {
    nvim = {
      enable = false; # do not generate file, allow LazyVim to manage its own config
      source = "${neovim_config}";
      recursive = true;
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
