-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local M = {}

-- augroup for csharp autocommands indent rules to avoid duplicates
local group = vim.api.nvim_create_augroup("CSharpSettings", { clear = true })

function M.setup()
  -- set indentation settings for C# files
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "cs",
    group = group,
    callback = function()
      -- use spaces for indentation
      vim.bo.expandtab = true
      -- set tab width to 4 spaces
      vim.bo.tabstop = 4
      -- set shift width (used for autoindent) to 4 spaces
      vim.bo.shiftwidth = 4
      -- set softtabstop to match shiftwidth
      vim.bo.softtabstop = 4
    end,
    desc = "Set 4-space indentation for C# files",
  })
end

return M
