{ pkgs, inputs, ... }:
{
  home.packages = with pkgs; [
    roslyn
    inputs.nixvim.packages.${pkgs.system}.default
  ];
}
