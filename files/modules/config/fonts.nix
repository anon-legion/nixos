{ pkgs, ... }:
{
  fonts = {
    fontDir.enable = true;
    enableDefaultPackages = true;
    packages = with pkgs; [
      nerd-fonts.fira-code
      nerd-fonts.jetbrains-mono
      nerd-fonts.iosevka-term
      nerd-fonts.iosevka-term-slab
    ];
    fontconfig = {
      enable = true;
      defaultFonts = {
        serif = [ "IosevkaTermSlab Nerd Font Propo" ];
        sansSerif = [ "FiraCode Nerd Font" ];
        monospace = [ "JetBrainsMono Nerd Font Mono" ];
      };
    };
  };
}
