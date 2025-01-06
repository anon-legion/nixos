return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    auto_install = true,
    highlight = {
      enable = true,
    },
    rainbow = {
      enable = true,
      extended_mode = true,
      max_file_lines = 1000,
    },
    indent = {
      enable = true,
    },
    ensure_installed = {
      "angular",
      "bash",
      "c_sharp",
      "css",
      "dockerfile",
      "html",
      "javascript",
      "json",
      "jsonc",
      "lua",
      "luadoc",
      "luap",
      "markdown",
      "markdown_inline",
      "nix",
      "regex",
      "typescript",
      "vim",
      "vimdoc",
      "yaml",
    },
  },
}
