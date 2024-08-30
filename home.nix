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

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
