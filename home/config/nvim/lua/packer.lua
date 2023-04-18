local fn = vim.fn
local cmd = vim.cmd
local fmt = string.format
local augroup = vim.api.nvim_create_augroup   -- Create/get autocommand group
local autocmd = vim.api.nvim_create_autocmd   -- Create autocommand



local packer_root = fn.stdpath 'data' .. '/site/pack/packer/opt/packer.nvim'
local packer_compiled = fn.stdpath 'cache' .. '/site/packer_compiled.vim'

local function ensure_packer_installed()
  -- Auto install packer.nvim if not exists
  if fn.empty(fn.glob(packer_root)) > 0 then
    vim.notify 'Downloading and installing packer.nvim.'
    fn.system { 'git', 'clone', 'https://github.com/wbthomason/packer.nvim', packer_root }

    -- If packer_compiled exists but packer plugin does not then the cache was
    -- deleted and needs to be resynced. Kill the compiled file and have it regenerate
    if vim.fn.exists(packer_compiled) then
      cmd(fmt([[call delete('%s')]], packer_compiled))
    end
  end
end

local packer = nil
local function init()
  ensure_packer_installed()

  if not packer then
    cmd [[ packadd! packer.nvim ]]
    packer = require 'packer'
  end

  packer.init({
    -- package_root = packer_root,
    compile_path = packer_compiled,
    disable_commands = true,
    ensure_dependencies = true,
    git = { clone_timeout = 120 },
    display = { open_fn = require'packer.util'.float },
  })

  packer.reset()

  local use = packer.use

  -- Packer can manage itself as an optional plugin
  use { 'wbthomason/packer.nvim', opt = true }

  -- -- terminal windows
  -- use 'akinsho/nvim-toggleterm.lua'

  -- -- finder
  -- use {
  --   'nvim-telescope/telescope.nvim',
  --   event = 'CursorHold',
  --   module_pattern = 'telescope.*',
  --   config = function()
  --     require'plugins.telescope'
  --   end,
  --   requires = {
  --     'nvim-lua/plenary.nvim',
  --     'nvim-lua/popup.nvim',
  --     'camgraff/telescope-tmux.nvim',
  --     'nvim-telescope/telescope-smart-history.nvim',
  --     {
  --       'nvim-telescope/telescope-fzf-native.nvim',
  --       run = 'make'
  --     },
  --     {
  --       'nvim-telescope/telescope-dap.nvim',
  --       requires = 'nvim-dap',
  --     },
  --     {
  --       'nvim-telescope/telescope-frecency.nvim',
  --       requires = 'tami5/sql.nvim',
  --       after = 'telescope.nvim',
  --     }
  --   },
  -- }


  -- -- lang completion and linting
  -- use {
  --   'kabouzeid/nvim-lspinstall',
  -- }

  -- use {
  --   'neovim/nvim-lspconfig',
  --   config = function() require 'plugins.lspconfig' end,
  --   event = 'BufRead',
  --   requires = {
  --     {
  --       'folke/trouble.nvim',
  --       requires = "kyazdani42/nvim-web-devicons",
  --       config = function()
  --         require 'trouble'.setup {}
  --       end
  --     },
  --     {
  --       'glepnir/lspsaga.nvim',
  --       config = function()
  --         require'lspsaga'.init_lsp_saga()
  --       end,
  --     },
  --     'nvim-lua/lsp_extensions.nvim',
  --     'onsails/lspkind-nvim'
  --   },
  -- }

  -- -- load compe in insert mode only
  -- use {
  --   'hrsh7th/nvim-compe',
  --   -- event = 'InsertEnter *',
  --   config = function() require 'plugins.compe' end,
  --   requires = {
  --     'rafamadriz/friendly-snippets',
  --     event = 'InsertCharPre'
  --   }
  -- }

  -- -- use { 'tzachar/compe-tabnine', run='./install.sh', requires = 'nvim-compe' }

  -- use {
  --   'simrat39/rust-tools.nvim',
  --   after = { 'nvim-lspconfig' },
  --   config = function() require'rust-tools'.setup({}) end
  -- }

  -- use {
  --   'abecodes/tabout.nvim',
  --   after = { 'nvim-compe' },
  --   requires = { 'nvim-compe' },
  --   wants = { 'nvim-treesitter' },
  --   config = function()
  --     require'tabout'.setup {
  --       ignore_beginning = true,
  --     }
  --   end
  -- }

  -- use {
  --   'nvim-treesitter/nvim-treesitter',
  --   requires = {
  --     'nvim-treesitter/nvim-treesitter-textobjects',
  --     'nvim-treesitter/nvim-treesitter-refactor',
  --     'lewis6991/spellsitter.nvim',
  --     'p00f/nvim-ts-rainbow'
  --   },
  --   run = ':TSUpdate',
  --   config = function()
  --     require 'plugins.treesitter'
  --   end
  -- }

  -- use {
  --   'ray-x/navigator.lua',
  --   requires = {
  --     'ray-x/guihua.lua',
  --     run = 'cd lua/fzy && make'
  --   },
  --   wants = { 'nvim-treesitter', 'nvim-lspconfig' },
  --   config = function() require 'navigator'.setup() end
  -- }



  -- -- -- syntax highlighting
  -- -- use {
  -- --     -- Fastest color-code colorizer
  -- --     'norcalli/nvim-colorizer.lua',
  -- --     config = function() require'colorizer'.setup({}) end
  -- -- }

  -- -- -- editor
  -- -- use {
  -- --   'windwp/nvim-autopairs',
  -- --   config = function() require'nvim-autopairs'.setup({}) end
  -- -- }

  -- -- use 'cohama/lexima.vim'


  -- -- -- tools
  -- -- -- use {
  -- -- --   'rmagatti/auto-session',
  -- -- --   config = function()
  -- -- --     -- auto restore session when open running nvim <path>
  -- -- --     -- autocmd BufEnter * ++nested call <SID>hijack_netrw()
  -- -- --     require'auto-session'.setup {}
  -- -- --   end,
  -- -- -- }



  -- -- debugger
  -- use {
  --   'mfussenegger/nvim-dap',
  --   module = 'dap',
  --   keys = { '<localleader>dc' },
  --   -- setup = conf('dap').setup,
  --   -- config = conf('dap').config,
  --   requires = {
  --     'rcarriga/nvim-dap-ui',
  --     requires = 'nvim-dap',
  --     after = 'nvim-dap',
  --     config = function()
  --       require'dapui'.setup()
  --     end,
  --   },
  -- }
end


local plugins = setmetatable({}, {
  __index = function(_, key)
    if not packer then
      init()
    end

    return packer[key]
  end,
})

function plugins.install_missing()
  if not packer then
    init()
  end

  -- packer.clean()
  packer.install()
  packer.compile()
  -- vim.notify 'packer installed and compiled...'
  vim.g.packer_compiled_loaded = false
end

if fn.has('vim_starting') > 0 then
  local self = fmt('%s/plugins*.lua', fn.expand '<sfile>:h')

  augroup('reloadPacker', { clear = true })
  autocmd('')
  augroup('vimrc_packer', {
    events = { 'SourcePost', 'BufWritePost' },
    targets = { self },
    command = function()
      package.loaded['plugins'] = nil
      require'plugins'.install_missing()
    end,
  })

  -- Commands
  cmd [[command! PackerInstall  lua require('plugins').install()]]
  cmd [[command! PackerCInstall lua require('plugins').install_missing()]]
  cmd [[command! PackerUpdate   lua require('plugins').update()]]
  cmd [[command! PackerSync     lua require('plugins').sync()]]
  cmd [[command! PackerClean    lua require('plugins').clean()]]
  cmd [[command! PackerStatus   lua require('plugins').status()]]
  cmd [[command! PackerProfile  lua require('plugins').profile_output()]]
  cmd [[command! -nargs=* PackerCompile  lua require('plugins').compile(<q-args>)]]

  plugins.install_missing()
end

if not vim.g.packer_compiled_loaded and vim.loop.fs_stat(packer_compiled) then
  vim.cmd(fmt('source %s', packer_compiled))
  vim.g.packer_compiled_loaded = true
end

return plugins
