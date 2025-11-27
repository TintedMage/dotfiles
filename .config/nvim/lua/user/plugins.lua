-- ~/.config/nvim/lua/user/plugins.lua

--------------------------------------------------
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

--------------------------------------------------
require("lazy").setup({
  -- 1. Colorscheme
  { "folke/tokyonight.nvim",
    lazy = false, -- Colorschemes should load early
    priority = 1000,
    config = function()
      -- TokyoNight has variants. 'storm' is a great minimal dark variant.
      require("tokyonight").setup({
        style = "night", -- or 'night', 'moon', 'day'
        transparent = true, -- Optional: If you want transparency built-in
        terminal_colors = true,
      })
      vim.cmd('colorscheme tokyonight-night')
    end,
  },

  -- 2. Treesitter (For beautiful, accurate highlighting)
  { 'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    opts = {
      highlight = { enable = true },
      indent = { enable = true },
      ensure_installed = { 'lua', 'vim', 'html', 'css', 'javascript', 'c', 'python' },
    },
  },

  -- 3. Lualine (Clean statusline)
  { 'nvim-lualine/lualine.nvim',
    opts = {
      options = {
        icons_enabled = true,
        theme = 'palenight',
        section_separators = { left = '', right = '' },
        component_separators = { left = '', right = '' },
      },
    },
  },

  -- 4. Telescope (Fuzzy Finder for fast file navigation)
  { 'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find Files' })
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Live Grep' })
      vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Find Buffers' })
    end
  },

  -- 5. Barbar (Bufferline)
  {'romgrk/barbar.nvim',
    dependencies = {
      'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
      'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
    },
    init = function() vim.g.barbar_auto_setup = false end,
    opts = {
      -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
      -- animation = true,
      -- insert_at_start = true,
      -- …etc.
    },
    version = '^1.0.0', -- optional: only update when a new 1.x version is released
  },

  -- 6. Comment.nvim (Easy comment/uncomment toggling)
  { 'numToStr/Comment.nvim',
    dependencies = { 'nvim-web-devicons' },
    event = 'BufEnter',
    config = function()
      require('Comment').setup()
      
      -- Map Ctrl + / and Ctrl + _ to the line-wise comment toggle
      vim.keymap.set({'n', 'v'}, '<C-/>', '<Plug>(comment_toggle_linewise_current)', { noremap = true, silent = true, desc = 'Toggle Line Comment' })
      vim.keymap.set({'n', 'v'}, '<C-_>', '<Plug>(comment_toggle_linewise_current)', { noremap = true, silent = true, desc = 'Toggle Line Comment' })
    end
  },


}) -- Correctly closes the table ({...}) and the setup function (setup(...))
