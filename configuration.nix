{ config, lib, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix 
    ./files/modules/config/hypr
    ./files/modules/config/boot.nix
    ./files/modules/config/fonts.nix
    ./files/modules/config/laptop.nix
    ./files/modules/config/network.nix
    ./files/modules/config/peripherals.nix
    ./files/modules/config/pkgs.nix
    ./files/modules/config/shells.nix
    ./files/modules/config/virtualization.nix
  ];

  time.timeZone = "Asia/Singapore";

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    users.thecomeback = {
      isNormalUser = true;
      description = "gio";
      extraGroups = [
        "networkmanager"
        "wheel"
        #"video"
      ];
    };
  };

  documentation.nixos.enable = false;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.sessionVariables = {
    FLAKE = "/home/thecomeback/.dotfiles";
  };

  system.stateVersion = "24.05";

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
    };
  };
}
