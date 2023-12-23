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

<<<<<<< Updated upstream
require('lazy').setup({
=======
lazy.setup({
>>>>>>> Stashed changes
  performance = {
    rtp = {
      reset = false, -- don't reset the runtime path to allow vim-plug plugins.
    },
  },

  spec = {
    -- Fix CursorHold Performance in neovim (https://github.com/neovim/neovim/issues/12587)
    { 'antoinemadec/FixCursorHold.nvim' },

    -- Icons
    { 'kyazdani42/nvim-web-devicons', lazy = true },

    -- LSP
    {
      'neovim/nvim-lspconfig',
      config = function()
        require('plugins.lsp')
      end
    },

    -- Adds extra functionality over rust analyzer
    { 'simrat39/rust-tools.nvim' },

    {
      "glepnir/lspsaga.nvim",
      event = "LspAttach",
      config = function()
        require("lspsaga").setup{}
      end
    },

    -- Visualize lsp progress
    {
      'j-hui/fidget.nvim',
      tag = 'legacy',
      config = function()
        require('fidget').setup()
      end
    },

    { "ray-x/lsp_signature.nvim", config = { hint_prefix = "🧸 " } },

    -- --  A more adventurous wildmenu
    -- {
    --   'gelguy/wilder.nvim'
    --   -- config = function()
    --   --   -- call wilder#setup({'modes': [':', '/', '?']})
    --   -- end
    -- },

    -- -- Autocomplete
    -- {
    --   'hrsh7th/nvim-cmp',
    --   event = 'InsertEnter',
    --   dependencies = {
    --     'L3MON4D3/LuaSnip',
    --     'hrsh7th/cmp-nvim-lsp', -- nvim-cmp source for neovim's built-in language server client.
    --     'hrsh7th/cmp-nvim-lsp-signature-help', -- nvim-cmp source for signature help
    --     'hrsh7th/cmp-nvim-lsp-document-symbol', -- nvim-cmp source for textDocument/documentSymbol.
    --     'hrsh7th/cmp-path', -- nvim-cmp source for filesystem paths.
    --     'hrsh7th/cmp-buffer', -- nvim-cmp source for buffer words.
    --     -- {
    --     --   'tzachar/cmp-tabnine', -- nvim-cmp source for tabnine..
    --     --   build = './install.sh',
    --     -- },
    --     'saadparwaiz1/cmp_luasnip', -- nvim-cmp source for luasnip.
    --   },
    --   config = function()
    --     require('plugins.cmp').setup{}
    --   end
    -- },

    -- {
    --   'tzachar/cmp-tabnine',
    --   build = './install.sh',
    --   dependencies = 'hrsh7th/nvim-cmp',
    -- },

    -- Autocomplete
    {
      'ms-jpq/coq_nvim',
      dependencies = {
        'ms-jpq/coq.artifacts',
        'ms-jpq/coq.thirdparty'
      },
      config = function()
        require('plugins.cmp').setup{}
      end
    },


    -- Snippets Engine
    {
      "L3MON4D3/LuaSnip",
      version = "2.0",
      build = "make install_jsregexp"
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
