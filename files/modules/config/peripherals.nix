{ pkgs, ... }:
{
  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
          # Name = "Computer";
          ControllerMode = "dual";
          FastConnectable = "true";
          Experimental = "true";
        };
        Policy = { AutoEnable = "true"; };
        LE = { EnableAdvMonInterleaveScan = "true"; };
      };
    };

    # Logitech unifying receiver used with logitech-udev-rules
    logitech.wireless = {
      enable = true;
      enableGraphical = true;
    };
  };
  
  # Ensures Pipewire processes get real time priority
  security.rtkit.enable = true;
  services = {
    # Enable devmon for device management
    devmon.enable = true;

    # Use Pipewire instead of Pulseaudio for sound
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      jack.enable = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };

    # Fingerprint sensor
    fprintd = {
      enable = true;
      package = pkgs.fprintd.overrideAttrs {
        mesonCheckFlags = [
          "--no-suite"
          "fprintd:TestPamFprintd"
        ];
      };
    };

    # Enable CUPS to print documents.
    printing.enable = false;
  };
}
