{ pkgs, ...}:
{
  boot = {
    consoleLogLevel = 0;
    kernelPackages = pkgs.linuxPackages_latest; # Keep linux kernel on latest version
    kernelParams = [ "quiet" "splash" ];
    #resumeDevice = "/dev/disk/by-partlabel/swap"; # Fix hibernate issue
    initrd.verbose = false;
    plymouth.enable = true; # animated boot splash screen
    loader = {
      timeout = 3;
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    }; 
  };
}
