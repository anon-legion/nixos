local M = {}

-- color definitions
M.colors = {
  pink = "#FF79C6",
  cyan = "#8BE9FD",
  purple = "#BD93F9",
  green = "#50FA7B",
  yellow = "#F1FA8C",
  red = "#FF5555",
  orange = "#FFB86C",
}

-- highlight groups
M.highlight_groups = {
  "DraculaPink",
  "DraculaCyan",
  "DraculaPurple",
  "DraculaGreen",
  "DraculaYellow",
  "DraculaRed",
  "DraculaOrange",
}

-- setup highligh groups
local function setup_highlights()
  local highlights = {
    DraculaPink = M.colors.pink,
    DraculaCyan = M.colors.cyan,
    DraculaPurple = M.colors.purple,
    DraculaGreen = M.colors.green,
    DraculaYellow = M.colors.yellow,
    DraculaRed = M.colors.red,
    DraculaOrange = M.colors.orange,
  }

  for name, color in pairs(highlights) do
    vim.api.nvim_set_hl(0, name, { fg = color })
  end
end

-- excluded filetypes
local excluded_filetypes = {
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
}

-- plugin config
return {
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = "LazyFile",
    opts = function()
      local hooks = require("ibl.hooks")
      -- register highlight setup hook with error handling
      hooks.register(hooks.type.HIGHLIGHT_SETUP, setup_highlights)

      -- configure rainbow delimiters
      vim.g.rainbow_delimiters = { highlight = M.highlight_groups }

      -- register scope highlight hook
      hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)

      -- setup toggle mapping
      LazyVim.toggle.map("<leader>ug", {
        name = "Indention Guides",
        get = function()
          return require("ibl.config").get_config(0).enabled
        end,
        set = function(state)
          local status_ok, ibl = pcall(require, "ibl")
          if status_ok then
            ibl.setup_buffer(0, { enabled = state })
          end
        end,
      })

      -- return configuration
      return {
        indent = {
          char = "│",
          tab_char = "│",
          highlight = M.highlight_groups,
        },
        exclude = {
          filetypes = excluded_filetypes,
        },
        scope = {
          enabled = false,
          show_start = true,
          show_end = false,
          highlight = M.highlight_groups,
        },
      }
    end,
  },
}
