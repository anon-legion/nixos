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
    [ 
      ./hardware-configuration.nix
    ];

  # Keep linux kernel on latest version
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    consoleLogLevel = 0;
    kernelParams = ["quiet" "splash"];
    initrd.verbose = false;
    plymouth.enable = true; # animated boot splash screen
    loader.timeout = 3; 
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
  };

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

  # Windowing system config
  services.xserver = {
    enable = true;
    xkb.layout = "us";
    desktopManager.gnome.enable = true;
    displayManager.gdm.enable = true;
    excludePackages = (with pkgs; [
      xterm
    ]);
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  # Enable sound.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    defaultUserShell = pkgs.fish;
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

  # Git
  programs.git = {
    enable = true;
    config = {
      user.email = "g.sync.mobile1@gmail.com";
      user.name = "thecomeback";
    };
  };

  # Shells
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

  environment = {
    shells = with pkgs; [ bash zsh fish ];
    systemPackages = with pkgs; [
      bat
      eza
      fastfetch
      fd
      fishPlugins.fzf-fish
      fishPlugins.tide
      fishPlugins.z
      fzf
      gcc
      htop
      lazygit
      openssh
      ripgrep
      tlp
      tmux
      unzip
      wget
      wl-clipboard
      (nerdfonts.override { fonts = [ "FiraCode" "JetBrainsMono" ]; })
    ] ++ (with pkgs.gnomeExtensions; [
      blur-my-shell
      bluetooth-quick-connect
      ddterm
      gtile
      space-bar
      vitals
    ]);
    gnome.excludePackages = (with pkgs; [
      # for packages that are pkgs.*
      epiphany # web browser
      evince # document viewer
      geary # email reader
      gnome-connections
      gnome-console
      gnome-tour
      gnome-weather
      seahorse # password manager
      xterm
      yelp
    ]);
  };

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
  services.power-profiles-daemon.enable = false; # disable built-in Gnome power management daemon
  services.tlp.enable = true;

  # Fingerprint sensor
  services.fprintd.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 22 ]; # default port for ssh is 22

  system.stateVersion = "24.05";

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;
  };

}

