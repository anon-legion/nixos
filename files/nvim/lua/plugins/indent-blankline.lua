local highlight = {
  "DraculaRed",
  "DraculaYellow",
  "DraculaPink",
  "DraculaOrange",
  "DraculaGreen",
  "DraculaViolet",
  "DraculaCyan",
}

local hooks = require("ibl.hooks")
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
  vim.api.nvim_set_hl(0, "DraculaRed", { fg = "#FF5555" })
  vim.api.nvim_set_hl(0, "DraculaYellow", { fg = "#F1FA8C" })
  vim.api.nvim_set_hl(0, "DraculaPink", { fg = "#FF79C6" })
  vim.api.nvim_set_hl(0, "DraculaOrange", { fg = "#FFB86C" })
  vim.api.nvim_set_hl(0, "DraculaGreen", { fg = "#50FA7B" })
  vim.api.nvim_set_hl(0, "DraculaViolet", { fg = "#BD93F9" })
  vim.api.nvim_set_hl(0, "DraculaCyan", { fg = "#8BE9FD" })
end)

return {
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "LazyFile",
    opts = function()
      LazyVim.toggle.map("<leader>ug", {
        name = "Indention Guides",
        get = function()
          return require("ibl.config").get_config(0).enabled
        end,
        set = function(state)
          require("ibl").setup_buffer(0, { enabled = state })
        end,
      })

      return {
        indent = {
          char = "│",
          tab_char = "│",
          highlight = highlight,
        },
        scope = { show_start = true, show_end = true },
        exclude = {
          filetypes = {
            "help",
            "alpha",
            "dashboard",
            "neo-tree",
            "Trouble",
            "trouble",
            "lazy",
            "mason",
            "notify",
            "toggleterm",
            "lazyterm",
          },
        },
      }
    end,
    main = "ibl",
  },
}
