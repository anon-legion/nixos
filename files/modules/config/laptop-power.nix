{ ... }:
{
  services = {
    # Disable built-in Gnome power management daemon
    power-profiles-daemon.enable = false;
    # Enable TLP power management daemon
    tlp.enable = true;
  };
}
