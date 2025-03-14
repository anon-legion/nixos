{ ... }:
{
  services.kdeconnect = {
    enable = true;
    indicator = true;
  };

  # Ports used by kdeconnect
  networking.firewall = rec {
    allowedTCPPortRanges = [ { from = 1714; to = 1764; } ];
    allowedUDPPortRanges = allowedTCPPortRanges;
  };
}
