{ ... }:
{
  virtualisation = {
    docker.rootless = {
      enable = true;
      setSocketVariable = true;
    };

    lxc = {
      enable = true;
      lxcfs.enable = true;
    };

    lxd = {
      enable = true;
      recommendedSysctlSettings = true;
      ui.enable = true;
    };
  };}
