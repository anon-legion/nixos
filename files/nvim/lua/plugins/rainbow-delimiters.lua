local M = {}

-- color definitions
M.colors = {
  pink = "#FF79C6",
  cyan = "#8BE9FD",
  purple = "#BD93F9",
  green = "#50FA7B",
  red = "#FF5555",
  blue = "#7AA2F7",
  orange = "#FFB86C",
}

-- highlight groups
M.highlight_groups = {
  "DraculaPink",
  "DraculaCyan",
  "DraculaPurple",
  "DraculaGreen",
  "DraculaRed",
  "DraculaBlue",
  "DraculaOrange",
}

return {
  "HiPhish/rainbow-delimiters.nvim",
  enabled = true,
  config = function()
    local highlights = {
      DraculaPink = M.colors.pink,
      DraculaCyan = M.colors.cyan,
      DraculaPurple = M.colors.purple,
      DraculaGreen = M.colors.green,
      DraculaRed = M.colors.red,
      DraculaBlue = M.colors.blue,
      DraculaOrange = M.colors.orange,
    }

    for name, color in pairs(highlights) do
      vim.api.nvim_set_hl(0, name, { fg = color })
    end

    vim.g.rainbow_delimiters = { highlight = M.highlight_groups }
  end,
}
