-- ========================================
-- Tinted Hyprland
-- Author: TintedMage (https://github.com/TintedMage)
-- Neovim: ~/.config/nvim/lua/user/plugins.lua
-- ========================================

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Plugin setup
require("lazy").setup({
  -- ========================================
  -- Colorschemes
  -- ========================================
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("tokyonight").setup({
        style = "night",
        transparent = true,
        terminal_colors = true,
      })
      vim.cmd("colorscheme tokyonight-night")
    end,
  },

  -- ========================================
  -- Syntax and Highlighting
  -- ========================================
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      highlight = { enable = true },
      indent = { enable = true },
      ensure_installed = { "lua", "vim", "html", "css", "javascript", "c", "python" },
    },
  },

  -- ========================================
  -- UI Enhancements
  -- ========================================
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        icons_enabled = true,
        theme = "palenight",
        section_separators = { left = "", right = "" },
        component_separators = { left = "", right = "" },
      },
    },
  },

  {
    "romgrk/barbar.nvim",
    dependencies = {
      "lewis6991/gitsigns.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    init = function()
      vim.g.barbar_auto_setup = false
    end,
    opts = {},
    version = "^1.0.0",
  },

  -- ========================================
  -- Navigation
  -- ========================================
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live Grep" })
      vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find Buffers" })
    end,
  },

  -- ========================================
  -- Utilities
  -- ========================================
  {
    "numToStr/Comment.nvim",
    dependencies = { "nvim-web-devicons" },
    event = "BufEnter",
    config = function()
      require("Comment").setup()
      vim.keymap.set({ "n", "v" }, "<C-/>", "<Plug>(comment_toggle_linewise_current)", {
        noremap = true,
        silent = true,
        desc = "Toggle Line Comment",
      })
      vim.keymap.set({ "n", "v" }, "<C-_>", "<Plug>(comment_toggle_linewise_current)", {
        noremap = true,
        silent = true,
        desc = "Toggle Line Comment",
      })
    end,
  },
})
