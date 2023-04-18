--
-- List all lua dependent plugins here (TODO: Do things the lua way)

-- Plugin manager: lazy.nvim
-- URL: https://github.com/folke/lazy.nvim

-- Install lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Use a protected call so we don't error out on first use
local status_ok, lazy = pcall(require, 'lazy')
if not status_ok then
  return
end

require('lazy').setup({
  performance = {
    rtp = {
      reset = false, -- don't reset the runtime path to allow vim-plug plugins.
    },
  },

  spec = {
    -- Fix CursorHold Performance in neovim (https://github.com/neovim/neovim/issues/12587)
    { 'antoinemadec/FixCursorHold.nvim' },

    -- Core
    { 'camspiers/animate.vim'                   }, -- animation library

    -- Icons
    { 'kyazdani42/nvim-web-devicons', lazy = true },

    -- Dashboard (flexibilitystart screen)
    {
      'goolord/alpha-nvim',
      dependencies = { 'kyazdani42/nvim-web-devicons' },
    },

    -- LSP
    { 'neovim/nvim-lspconfig' },

    {
      "glepnir/lspsaga.nvim",
      event = "LspAttach",
      config = function()
        require("lspsaga").setup({})
      end
    },

    -- Adds extra functionality over rust analyzer
    { 'simrat39/rust-tools.nvim' },

    -- Visualize lsp progress
    {
      'j-hui/fidget.nvim',
      config = function()
        require('fidget').setup()
      end
    },

    -- Treesitter
    { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },

    --  A more adventurous wildmenu
    {
      'gelguy/wilder.nvim'
      -- config = function()
      --   -- call wilder#setup({'modes': [':', '/', '?']})
      -- end
    },

    -- Autocomplete
    {
      'hrsh7th/nvim-cmp',
      -- load cmp on InsertEnter
      event = 'InsertEnter',
      -- these dependencies will only be loaded when cmp loads
      -- dependencies are always lazy-loaded unless specified otherwise
      dependencies = {
        'L3MON4D3/LuaSnip',
        'hrsh7th/cmp-nvim-lsp', -- nvim-cmp source for neovim's built-in language server client.
        'hrsh7th/cmp-path', -- nvim-cmp source for filesystem paths.
        'hrsh7th/cmp-buffer', -- nvim-cmp source for buffer words.
        'saadparwaiz1/cmp_luasnip', -- nvim-cmp source for luasnip.
      },
    },

    -- Autopair
    {
      'windwp/nvim-autopairs',
      event = 'InsertEnter',
      config = function()
        require('nvim-autopairs').setup{}
      end
    },

    {
      "folke/which-key.nvim",
      config = function()
        require('plugins.which-key').setup{}
      end,
    },

  },

})
