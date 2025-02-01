{ pkgs, ... }:
{
  environment = {
    systemPackages = with pkgs; [
      bat
      btop
      gthumb
      gcc
      inkscape-with-extensions
      lazygit
      libsecret
      lollypop
      lunarvim
      menulibre
      onlyoffice-desktopeditors
      openssh
      openssl
      p7zip
      rofi-wayland
      ripgrep
      tlrc # tldr in rust
      tmux
      unzip
      wget
      wl-clipboard
      xh
      zoxide
    ];
  };

  programs = {
    firefox.enable = true;

    git = {
      enable = true;
      config = {
        user.email = "g.sync.mobile1@gmail.com";
        user.name = "thecomeback";
        core.askPass = "";
        credential.helper = "";
      };
    };

    # nh nix helper
    nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 7d --keep 5";
    };
  };
}
