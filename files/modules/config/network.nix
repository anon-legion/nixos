{ ... }:
{
  networking = {
    hostName = "nixos-goober";
    firewall = rec {
      allowedTCPPorts = [ 22 ]; # default port for ssh is 22
      checkReversePath = "loose"; # fix not internet when tailscale up

      # Ports used by kdeconnect
      allowedTCPPortRanges = [ { from = 1714; to = 1764; } ];
      allowedUDPPortRanges = allowedTCPPortRanges;
    };
    networkmanager.enable = true;
  };

  services = {
    # Enable the OpenSSH daemon.
    openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = true;
      };
    };

    # Enable Tailscale vpn
    tailscale = {
      enable = true;
      useRoutingFeatures = "client";
    };
  };
}
