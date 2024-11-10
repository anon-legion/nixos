return {
  {
    "williamboman/mason.nvim",
    -- Disable Mason in favor of Nix packages
    enabled = false,
    --opts = function(_, opts)
    --  vim.list_extend(opts.ensure_installed, {
    --    "bash-language-server",
    --    "json-lsp",
    --    "lua-language-server",
    --    "markdownlint",
    --    "prettier",
    --    "stylua",
    --    "yaml-language-server",
    --  })
    --end,
  },
}
