local M = {}

function M.setup()
  local loaded, wk = pcall(require, 'which-key')
  if not loaded then
    return
  end

  vim.o.timeout = true
  vim.o.timeoutlen = 480

  wk.register({
    [' '] = 'write file if modified',
<<<<<<< Updated upstream

    q = { ':quit<cr>',   'close buffer' },
    Q = { ':quit<cr>',   'close window' },
    e = { ':File<cr>',   'edit files' },
    d = { ':Drawer<cr>', 'toggle file drawer' },
=======
    q = { ':WintabsClose<cr>', 'close buffer' },
    Q = { ':quit<cr>',         'close window' },
    e = { ':File<cr>',         'edit files' },
    d = { ':Drawer<cr>',       'toggle file drawer' },
>>>>>>> Stashed changes

    -- . is for vimrc
    ['.'] = {
      name = '+config',
      ['p'] = { ':e $VIM_ROOT/plugins.vim<cr>',             'open plugins' },
      ['g'] = { ':e $VIM_ROOT/general.vim<cr>',             'open general conf' },
      ['s'] = { ':e $VIM_ROOT/conf.d/statusline.vim<cr>',   'open statusline conf' },
      ['c'] = { ':e $VIM_ROOT/conf.d/colorscheme.vim<cr>',  'open colorscheme conf' },
      ['t'] = { ':e $VIM_ROOT/conf.d/terminal.vim<cr>',     'open terminal conf' },
      ['.'] = {
        function()
          print(vim.bo.filetype)
          -- if vim.bo.filetype == 'vim' then
          --   vim.cmd 'so %'
          --   print("vim: sourced "..vim.fn.bufname("%"))
          -- elseif vim.bo.filetype == 'lua' then
          --   vim.cmd 'luafile %'
          -- else
          --   vim.cmd 'so %MYVIMRC'
          -- end
        end,
        'source current file or reload vimrc'
      },
    },

    -- f is for fzf/find
    f = {
      name  = '+find',
      ['w'] = {':call fzf#__open("FRg")<cr>',       'find word'},
      ['f'] = {':call fzf#__open("FFiles")<cr>',    'find files'},
      ['c'] = {':call fzf#__open("FColors")<cr>',   'find colors'},
      ['C'] = {':call fzf#__open("FCommands")<cr>', 'find commands'},
      ['B'] = {':call fzf#__open("FBuffers")<cr>',  'find buffers'},
      ['b'] = {':call fzf#__open("FMarks")<cr>',    'find bookmarks'},
      ['h'] = {':call fzf#__open("FHistory")<cr>',  'find history'},
      ['t'] = {':call fzf#__open("FHelptags")<cr>', 'find help'},
    },

    -- w is for window
    w = {
      name = '+windows',
      ['w'] = {'<C-W>w',         'other-window'},
      ['d'] = {'<C-W>c',         'delete-window'},
      ['-'] = {'<C-W>s',         'split-window-below'},
      ['|'] = {'<C-W>v',         'split-window-right'},
      ['2'] = {'<C-W>v',         'layout-double-columns'},
      ['h'] = {'<C-W>h',         'window-left'},
      ['j'] = {'<C-W>j',         'window-below'},
      ['l'] = {'<C-W>l',         'window-right'},
      ['k'] = {'<C-W>k',         'window-up'},
      ['H'] = {'<C-W>5<',        'expand-window-left'},
      ['J'] = {':resize +5<cr>', 'expand-window-below'},
      ['L'] = {'<C-W>5>',        'expand-window-right'},
      ['K'] = {':resize -5<cr>', 'expand-window-up'},
      ['='] = {'<C-W>=',         'balance-window'},
      ['s'] = {'<C-W>s',         'split-window-below'},
      ['v'] = {'<C-W>v',         'split-window-below'},
      ['?'] = {':FWindows<cr>',  'fzf-window'},
    },

  }, {prefix = "<leader>"})

  wk.register({
    d = {
      name = '+debugger',
      b = 'dap: toggle breakpoint',
      B = 'dap: set breakpoint',
      c = 'dap: continue or start debugging',
      e = 'dap: step out',
      i = 'dap: step into',
      o = 'dap: step over',
      l = 'dap REPL: run last',
      t = 'dap REPL: toggle',
    },
  }, {
    prefix = '<localleader>',
  })
end

return M

-- vim: sw=2 sts=2 tw=0 fdm=marker
