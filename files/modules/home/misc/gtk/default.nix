{ pkgs, ... }:
{
  # GTK theme configuration
  gtk = {
    enable = true;
    iconTheme = {
      name = "Tela-circle-dark";
      package = pkgs.tela-circle-icon-theme;
    };
    cursorTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
      size = 24;
    };
    font = {
      name = "FiraCode Nerd Font";
      size = 11;
    };
    theme = {
      name = "Dracula";
      package = pkgs.dracula-theme;
    };
    gtk3 = {
      bookmarks = [
        "file:///home/thecomeback/Desktop"
        "file:///home/thecomeback/Documents"
        "file:///home/thecomeback/Downloads"
        "file:///home/thecomeback/Music"
        "file:///home/thecomeback/Pictures"
        "file:///home/thecomeback/Videos"
      ];
    };
  };
}
