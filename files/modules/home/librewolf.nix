{ ... }:
{
  programs.librewolf = {
    enable = true;
    settings = {
      "privacy.resistFingerprinting" = true;
    };
  };
}
