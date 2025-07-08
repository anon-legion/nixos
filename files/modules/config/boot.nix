{ pkgs, ...}:
{
  boot = {
    consoleLogLevel = 0;
    # kernelPackages = pkgs.linuxPackages_testing; # Keep linux kernel on latest rc version
    # kernelPackages = pkgs.linuxPackages_latest; # Keep linux kernel on latest version
    kernelPackages = pkgs.linuxPackages; # Pin linux kernel to LTS
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

  hardware.enableAllFirmware = true;

}
