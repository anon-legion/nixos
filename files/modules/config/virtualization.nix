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

  programs.virt-manager.enable = true;

  hardware.ksm.enable = true;

  users.groups.libvirtd.members = [ "thecomeback"];

  networking = {
    nftables.enable = true;
    firewall.trustedInterfaces = [ "incusbr0" ];
  };

  virtualisation = {
    docker.rootless = {
      enable = true;
      setSocketVariable = true;
    };

    incus = {
      enable = true;
    };

    libvirtd = {
      enable = true;
      qemu = {
        swtpm.enable = true;
        ovmf.enable = true;
        ovmf.packages = [ pkgs.OVMFFull.fd ];
      };
    };

    lxc = {
      enable = true;
      lxcfs.enable = true;
    };

    # lxd = {
    #   enable = true;
    #   recommendedSysctlSettings = true;
    # };

    spiceUSBRedirection.enable = true;
  };

  services.spice-vdagentd.enable = true;
}
