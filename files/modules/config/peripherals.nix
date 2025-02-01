{ pkgs, ... }:
{
  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
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
    # Use Pipewire instead of Pulseaudio for sound
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
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
    printing.enable = true;
  };
}
