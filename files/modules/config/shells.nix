{ pkgs, ... }:
let
  aliasBinds = {
    g = "git";
    ff = "fastfetch";
    ll = "exa -lhgb --icons --git --group-directories-first";
    lla = "exa -lhgab --icons --git --group-directories-first";
    ls = "exa --icons --group-directories-first";
    lsa = "exa -a --icons --group-directories-first";
    lt = "exa --tree --icons --group-directories-first";
    lta = "exa -a --tree --icons --group-directories-first";
    open = "xdg-open";
  };
in
{
  environment = {
    shells = with pkgs; [ bash fish ];
    systemPackages = with pkgs; [
      bat
      eza
      fastfetch
      fd
      fishPlugins.autopair
      fishPlugins.bass
      fishPlugins.fzf-fish
      fishPlugins.sponge
      fishPlugins.tide
      fzf
    ];
  };

  programs = {
    bash = {
      shellAliases = aliasBinds;
    };
    fish = {
      enable = true;
      shellAliases = aliasBinds;
    };
  };

  users.defaultUserShell = pkgs.fish;
}
