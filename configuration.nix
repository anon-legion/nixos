#aj Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

let
  aliasBinds = {
    ".." = "cd ..";
    g = "git";
    ll = "exa -lhg --icons";
    lla = "exa -lhga --icons";
    ls = "exa --icons";
    lsa = "exa -a --icons";
    lt = "exa --tree --icons";
    lta = "exa -a --tree --icons";
  };
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Keep linux kernel on latest version
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos-goober";
  networking.networkmanager.enable = true;

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
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    desktopManager.gnome.enable = true;
    displayManager.gdm.enable = true;
    xkb.layout = "us";
    excludePackages = (with pkgs; [
      xterm
    ]);

  };
  

  # Configure keymap in X11
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  # Enable sound.
  hardware.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  security.rtkit.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    defaultUserShell = pkgs.fish;
    users.thecomeback = {
      isNormalUser = true;
      description = "gio";
      extraGroups = [ "networkmanager" "wheel" ];
      packages = with pkgs; [
      ];
    };
  };

  # Neovim
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
    configure = {
      packages.myVimPackage = with pkgs.vimPlugins; {
        start = [
          LazyVim
        ];
      };
    };
  };

  # Git
  programs.git = {
    enable = true;
    config = {
      user.email = "g.sync.mobile1@gmail.com";
      user.name = "thecomeback";
    };
  };

  # Shells
  environment.shells = with pkgs; [ bash zsh fish ];
  programs = {
    bash = {
      shellAliases = aliasBinds;
    };
    zsh = {
      enable = true;
      shellAliases = aliasBinds;
    };
    fish = {
      enable = true;
      shellAliases = aliasBinds;
    };
  };

  # Firefox
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    bat
    eza
    fastfetch
    fd
    fishPlugins.fzf-fish
    fishPlugins.tide
    fishPlugins.z
    fzf
    htop
    openssh
    tlp
    tmux
    wget
    (nerdfonts.override { fonts = [ "FiraCode" "JetBrainsMono" ]; })
  ] ++ (with pkgs.gnomeExtensions; [
    blur-my-shell
    bluetooth-quick-connect
    ddterm
    gtile
    space-bar
    vitals
  ]);

  environment.gnome.excludePackages = (with pkgs; [
    # for packages that are pkgs.*
    epiphany # web browser
    evince # document viewer
    geary # email reader
    gnome-connections
    gnome-console
    gnome-tour
    seahorse
    xterm
    yelp
  ]) ++ (with pkgs.gnome; [
    # for packages that are pkgs.gnome.*
    gnome-weather
  ]);

  fonts = {
    fontDir.enable = true;
    enableDefaultPackages = true;
    packages = with pkgs; [
      (nerdfonts.override { fonts = [ "FiraCode" "JetBrainsMono" ]; })
    ];
    fontconfig = {
      enable = true;
      defaultFonts = {
        serif = [  "JetBrainsMono Nerd Font" ];
        sansSerif = [  "JetBrainsMono Nerd Font" ];
        monospace = [  "JetBrainsMono Nerd Font Mono" ];
      };
    };
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  #services.openssh = {
  #  enable = true;
  #  settings = {
  #    PermitRootLogin = "no";
  #    PasswordAuthentication = true;
  #  };
  #};

  # Enable TLP power management daemon
  services.power-profiles-daemon.enable = false; # <- disable built-in Gnome power management daemon
  services.tlp.enable = true;

  services.fprintd.enable = true;

  # Open ports in the firewall.
  #networking.firewall.allowedTCPPorts = [ 22 ]; # default port for ssh is 22
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.05"; # Did you read the comment?

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

}

