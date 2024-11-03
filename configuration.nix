{ config, lib, pkgs, ... }:

let
  aliasBinds = {
    ".." = "cd ..";
    g = "git";
    ff = "fastfetch";
    ll = "exa -lhg --icons";
    lla = "exa -lhga --icons";
    ls = "exa --icons";
    lsa = "exa -a --icons";
    lt = "exa --tree --icons";
    lta = "exa -a --tree --icons";
  };
in
{
  imports = [ ./hardware-configuration.nix ];

  boot = {
    consoleLogLevel = 0;
    kernelPackages = pkgs.linuxPackages_latest; # Keep linux kernel on latest version
    kernelParams = ["quiet" "splash"];
    #resumeDevice = "/dev/disk/by-partlabel/swap"; # Fix hibernate issue
    initrd.verbose = false;
    plymouth.enable = true; # animated boot splash screen
    loader = {
      timeout = 3;
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    }; 
  };

  networking = {
    hostName = "nixos-goober";
    firewall.allowedTCPPorts = [ 22 ]; # default port for ssh is 22
    networkmanager.enable = true;
  };

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
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    excludePackages = (with pkgs; [
      xterm
    ]);
  };

  hardware.enableAllFirmware = true;

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

  # GSConnect
  programs.kdeconnect = {
    enable = true;
    package = pkgs.gnomeExtensions.gsconnect;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment = {
    shells = with pkgs; [ bash zsh fish nushell];
    systemPackages = with pkgs; [
      bat
      beauty-line-icon-theme
      btop
      candy-icons
      dracula-theme
      gnome-tweaks
      gss
      gthumb
      eza
      fastfetch
      fd
      fishPlugins.bass
      fishPlugins.fzf-fish
      fishPlugins.tide
      fishPlugins.z
      fzf
      gcc
      htop
      inkscape-with-extensions
      lazygit
      libsecret
      lollypop
      menulibre
      onlyoffice-desktopeditors
      openssh
      pinentry-all # provides a console to enter a passphrase when gpg is run and needs it
      sweet-folders
      ripgrep
      tlp
      tlrc
      tmux # tldr in rust
      unzip
      wget
      wl-clipboard
      zoxide
      (nerdfonts.override { fonts = [ 
          "FiraCode"
          "JetBrainsMono"
          "IosevkaTerm"
          "IosevkaTermSlab"
        ]; 
      })
    ] ++ (with pkgs.gnomeExtensions; [
      blur-my-shell
      bluetooth-quick-connect
      ddterm
      gsconnect
      logo-menu
      places-status-indicator
      privacy-settings-menu
      quick-settings-tweaker
      space-bar
      vitals
    ]);
    gnome.excludePackages = with pkgs; [
      epiphany # web browser
      evince # document viewer
      geary # email reader
      gnome-connections
      gnome-console
      gnome-music
      gnome-tour
      gnome-weather
      #seahorse # password manager
      xterm
      yelp
    ];
  };
  documentation.nixos.enable = false;

  fonts = {
    fontDir.enable = true;
    enableDefaultPackages = true;
    packages = with pkgs; [
      (nerdfonts.override { fonts = [ 
          "FiraCode"
          "JetBrainsMono"
          "IosevkaTerm"
          "IosevkaTermSlab"
        ]; 
      })
    ];
    fontconfig = {
      enable = true;
      defaultFonts = {
        serif = [ "IosevkaTermSlab Nerd Font Propo" ];
        sansSerif = [ "FiraCode Nerd Font" ];
        monospace = [ "JetBrainsMono Nerd Font Mono" ];
      };
    };
  };

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = true;
    };
  };

  # Enable TLP power management daemon
  services.power-profiles-daemon.enable = false; # disable built-in Gnome power management daemon
  services.tlp.enable = true;

  # Fingerprint sensor
  services.fprintd = {
    enable = true;
    package = pkgs.fprintd.overrideAttrs {
      mesonCheckFlags = [
        "--no-suite"
        "fprintd:TestPamFprintd"
      ];
    };
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  system.stateVersion = "24.05";

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };
}

