{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    btop
    font-awesome
    gcc
    gparted
    gthumb
    inkscape-with-extensions
    lazygit
    libsecret
    lollypop
    menulibre
    onlyoffice-desktopeditors
    openssh
    openssl
    p7zip
    playerctl
    ripgrep
    tlrc # tldr in rust
    tmux
    unzip
    wget
    wl-clipboard
    xh
    zoxide
  ];

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
