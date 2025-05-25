{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    font-awesome
    gcc
    gthumb
    inkscape-with-extensions
    libsecret
    lollypop
    menulibre
    onlyoffice-desktopeditors
    openssh
    openssl
    p7zip
    playerctl
    unzip
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
      flake = "/home/thecomeback/.dotfiles";
    };
  };
}
