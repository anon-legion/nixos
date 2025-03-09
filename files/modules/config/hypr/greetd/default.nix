{ pkgs, ... }:
{
  services = {
    greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --remember --remember-session --asterisks --container-padding 6 --theme 'time=lightgreen;action=green;text=cyan;button=magenta;border=cyan;title=lightcyan;prompt=lightmagenta;input=cyan' --cmd Hyprland";
          user = "greeter";
        };
      };
    };
  };

  security.pam.services = {
    greetd.fprintAuth = false;
    tuigreet.fprintAuth = false;
  };

  systemd.services.greetd.serviceConfig = {
    Type = "idle";
    StandardInput = "tty";
    StandardOutput = "tty";
    StandardError = "journal"; # Without this errors will spam on screen

    # Without these bootlogs will spam on screen
    TTYReset = true;
    TTYVHangup = true;
    TTYVTDisallocate = true;
  };

}
