-- ========================================
-- Tinted Hyprland
-- Author: TintedMage (https://github.com/TintedMage)
-- Neovim: ~/.config/nvim/lua/user/options.lua
-- ========================================

local opt = vim.opt

-- Aesthetic/UI
opt.number = true          -- Show absolute line numbers
opt.termguicolors = true   -- Enable true colors
--opt.signcolumn = "yes"     -- Always show the sign column (for LSPs)
opt.wrap = false           -- Disable line wrapping
opt.cursorline = true      -- Highlight the current line
opt.scrolloff = 8          -- Keep 8 lines above/below cursor when scrolling

-- Tabs/Indentation (4 spaces is a common choice)
opt.expandtab = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.smartindent = true
opt.autoindent = true

-- Searching
opt.ignorecase = true      -- Ignore case in search patterns
opt.smartcase = true       -- ...unless the pattern contains upper case
opt.hlsearch = true        -- Highlight all matches

-- System
opt.undofile = true        -- Persistent undo
opt.swapfile = false       -- No swap files
opt.splitright = true      -- Split windows vertically to the right
opt.splitbelow = true      -- Split windows horizontally to the bottom
