{ pkgs, ... }:
{
  imports = [
    ./files/modules/home/hypr
    ./files/modules/home/cli.nix
    ./files/modules/home/ghostty.nix
    ./files/modules/home/gpg.nix
    ./files/modules/home/neovim.nix
    ./files/modules/home/pkgs.nix
  ];

  home = {
    username = "thecomeback";
    homeDirectory = "/home/thecomeback";
    stateVersion = "24.05";
    sessionPath = [
      "$HOME/.dotnet/tools"
      "${pkgs.omnisharp-roslyn}"
    ];
    sessionVariables = {
      DOTNET_ROOT = "${pkgs.dotnet-sdk_8}";
    };
  };

  gtk = {
    enable = true;
    font = {
      name = "FiraCode Nerd Font";
    };
  };

  nixpkgs.config.allowUnfree = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
