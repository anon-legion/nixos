{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    virt-viewer
    spice
    spice-gtk
    spice-protocol
    win-virtio
    win-spice
  ];

  programs.virt-manager = {
    enable = true;
    extraConfig = ''
      [virt-viewer]
      default-zoom = 1.0
      default-scale = 1.0
    '';
  };

  hardware.ksm.enable = true;

  users.groups.libvirtd.members = [ "thecomeback"];

  virtualisation = {
    docker.rootless = {
      enable = true;
      setSocketVariable = true;
    };

    libvirtd = {
      enable = true;
      qemu = {
        # withVhostUser = true;
        # withVhostSCSI = true;
        # withVhostUserFS = true;
        # withVhostUserNet = true;
        # withVhostUserGPU = true;
        swtpm.enable = true;
        ovmf.enable = true;
        ovmf.packages = [ pkgs.OVMFFull.fd ];
      };
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

    spiceUSBRedirection.enable = true;
  };

  services.spice-vdagentd.enable = true;
}
