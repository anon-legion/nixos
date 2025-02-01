{ ... }:
{
  services = {
    # Disable built-in Gnome power management daemon
    power-profiles-daemon.enable = false;
    # Enable TLP power management daemon
    services.tlp.enable = true;
  };
}
