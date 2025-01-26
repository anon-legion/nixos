{ config, lib, pkgs, ... }:

let
  aliasBinds = {
    g = "git";
    ff = "fastfetch";
    ll = "exa -lhgb --icons --git --group-directories-first";
    lla = "exa -lhgab --icons --git --group-directories-first";
    ls = "exa --icons --group-directories-first";
    lsa = "exa -a --icons --group-directories-first";
    lt = "exa --tree --icons --group-directories-first";
    lta = "exa -a --tree --icons --group-directories-first";
    open = "xdg-open";
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
  security.rtkit.enable = true;
  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Logitech Unifying Receiver used with logitech-udev-rules
  hardware.logitech.wireless = {
    enable = true;
    enableGraphical = false;
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
      core.askPass = "";
      credential.helper = "";
    };
  };

  # Shells
  programs = {
    bash = {
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

  # nh nix helper
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 7d --keep 5";
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment = {
    shells = with pkgs; [ bash fish ];
    sessionVariables = {
      FLAKE = "/home/thecomeback/.dotfiles";
    };
    systemPackages = with pkgs; [
      bat
      btop
      candy-icons
      dracula-theme
      gnome-tweaks
      gthumb
      eza
      fastfetch
      fd
      fishPlugins.bass
      fishPlugins.fzf-fish
      fishPlugins.tide
      fzf
      gcc
      inkscape-with-extensions
      lazygit
      libsecret
      logitech-udev-rules
      lollypop
      lunarvim
      menulibre
      onlyoffice-desktopeditors
      openssh
      openssl
      p7zip
      pop-launcher
      sweet-folders
      ripgrep
      tlp
      tlrc # tldr in rust
      tmux
      unzip
      wget
      wl-clipboard
      zoxide
    ] ++ (with pkgs.gnomeExtensions; [
      blur-my-shell
      bluetooth-quick-connect
      dash-to-dock
      ddterm
      gsconnect
      just-perfection
      logo-menu
      places-status-indicator
      pop-shell
      privacy-settings-menu
      quake-terminal
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
      # seahorse # password manager
      xterm
      yelp
    ];
  };
  documentation.nixos.enable = false;

  fonts = {
    fontDir.enable = true;
    enableDefaultPackages = true;
    packages = with pkgs; [
      nerd-fonts.fira-code
      nerd-fonts.jetbrains-mono
      nerd-fonts.iosevka-term
      nerd-fonts.iosevka-term-slab
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
    #gc = {
    #  automatic = true;
    #  dates = "weekly";
    #  options = "--delete-older-than 30d";
    #};
  };
}
