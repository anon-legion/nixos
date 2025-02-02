{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-unwrapped;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    withNodeJs = true;
    withPython3 = true;

    extraPackages = with pkgs; [
      bash-language-server
      csharpier
      lua-language-server
      markdownlint-cli
      nixd
      omnisharp-roslyn
      # roslyn-ls
      nodePackages.eslint
      nodePackages.prettier
      stylua
      typescript-language-server
      vscode-langservers-extracted
      yaml-language-server
    ];
  };

  home = {
    sessionPath = [
      "$HOME/.local/share/nvim/mason/bin"
    ];
    sessionVariables = {
      EDITOR = "nvim";
    };
  };

  xdg.configFile = {
    nvim = {
      enable = false;
      source = ./files/nvim;
      recursive = true;
    };
  };
}
