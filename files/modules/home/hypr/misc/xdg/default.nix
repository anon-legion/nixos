{...}: 
{
  xdg = {
    enable = true;
    mimeApps = {
      enable = true;
      associations.added = {
        "audio/mp4"= ["org.gnome.Lollypop.desktop"];
        "audio/mpeg" = ["org.gnome.Lollypop.desktop"];
        "image/jpeg" = ["org.gnome.Loupe.desktop"];
        "image/jpg" = ["org.gnome.Loupe.desktop"];
        "image/png" = ["org.gnome.Loupe.desktop"];
        "video/mp3" = ["org.gnome.Totem.desktop"];
        "video/mp4" = ["org.gnome.Totem.desktop"];
        "video/quicktime" = ["org.gnome.Totem.desktop"];
        "video/webm" = ["org.gnome.Totem.desktop"];
      };
      defaultApplications = {
        "application/json" = ["gnome-text-editor.desktop"];
        "application/octet-stream" = ["org.gnome.Nautilus.desktop"];
        "application/pdf" = ["onlyoffice-desktopeditors.desktop"];
        "application/toml" = ["org.gnome.TextEditor.desktop"];
        "application/x-gnome-saved-search" = ["org.gnome.Nautilus.desktop"];
        "inode/directory" = ["org.gnome.Nautilus.desktop"];
        "audio/*" = ["org.gnome.Lollypop.desktop"];
        "audio/mp3" = ["org.gnome.Lollypop.desktop"];
        "audio/mp4"= ["org.gnome.Lollypop.desktop"];
        "image/*" = ["org.gnome.Loupe.desktop"];
        "image/jpg" = ["org.gnome.Loupe.desktop"];
        "image/png" = ["org.gnome.Loupe.desktop"];
        "text/html" = ["firefox.desktop"];
        "text/plain" = ["org.gnome.TextEditor.desktop"];
        "video/*" = ["org.gnome.Totem.dekstop"];
        "video/mp4" = ["org.gnome.Totem.dekstop"];
        "x-scheme-handler/about" = ["firefox.desktop"];
        "x-scheme-handler/http" = ["firefox.desktop"];
        "x-scheme-handler/https" = ["firefox.desktop"];
        "x-scheme-handler/unknown" = ["firefox.desktop"];
      };
    };
    userDirs = {
      enable = true;
      createDirectories = true;
    };
  };
}
