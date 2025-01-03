-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Modes
-- Normal = "n"
-- Insert = "i"
-- Visual = "v"
-- Visual Block = "n"
-- Terminal = "t"
-- Command = "c"

local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Visual mode --
-- move selected line
keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", opts)
keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", opts)

-- retain yank value in register after paste over selection
keymap("v", "p", '"_dP', opts)
