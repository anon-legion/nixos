{ pkgs, inputs, ... }:
{
  home.packages = with pkgs; [
    roslyn
    inputs.nixvim.packages.x86_64-linux.default
  ];
}
