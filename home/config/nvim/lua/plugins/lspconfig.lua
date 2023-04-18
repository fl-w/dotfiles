-- nvim-lspconfig configuration

local loaded, lspconfig = pcall(require, 'lspconfig')
if not loaded then
  return
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches.
-- Add your language server below:
local servers = { 'bashls', 'pyright', 'html', 'cssls', 'tsserver' }

-- Call setup
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    root_dir = root_dir,
    capabilities = capabilities,
    flags = {
      -- default in neovim 0.7+
      debounce_text_changes = 150,
    }
  }
end

-- Add additional capabilities supported by nvim-cmp
-- See: https://github.com/neovim/nvim-lspconfig/wiki/Autocompletion
local capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp_nvim_lsp_loaded, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if cmp_nvim_lsp_loaded then
  capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
end

local wk_loaded, wk = pcall(require, 'which-key')
if wk_loaded then
    wk.register({
    l = {
      name  = '+find',
       ['.'] : { ':e $VIM_ROOT/lua/plugins/lspconfig.lua',                        'config' },
      ['w'] = {':call fzf#__open("FRg")<cr>',       'find word'},
      ['f'] = {':call fzf#__open("FFiles")<cr>',    'find files'},
      ['c'] = {':call fzf#__open("FColors")<cr>',   'find colors'},
      ['C'] = {':call fzf#__open("FCommands")<cr>', 'find commands'},
      ['B'] = {':call fzf#__open("FBuffers")<cr>',  'find buffers'},
      ['b'] = {':call fzf#__open("FMarks")<cr>',    'find bookmarks'},
      ['h'] = {':call fzf#__open("FHistory")<cr>',  'find history'},
      ['t'] = {':call fzf#__open("FHelptags")<cr>', 'find help'},
    },

    })


end

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Highlighting references.
    -- See: https://sbulav.github.io/til/til-neovim-highlight-references/
    -- for the highlight trigger time see: `vim.opt.updatetime`
    if ev.client.server_capabilities.documentHighlightProvider then
      vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })
      vim.api.nvim_clear_autocmds { buffer = bufnr, group = "lsp_document_highlight" }
      vim.api.nvim_create_autocmd("CursorHold", {
        callback = vim.lsp.buf.document_highlight,
        buffer = bufnr,
        group = "lsp_document_highlight",
        desc = "Document Highlight",
      })
      vim.api.nvim_create_autocmd("CursorMoved", {
        callback = vim.lsp.buf.clear_references,
        buffer = bufnr,
        group = "lsp_document_highlight",
        desc = "Clear All the References",
      })
    end

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap=true, silent=true, buffer=bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '[e', vim.lsp.diagnostic.goto_prev, bufopts)
    vim.keymap.set('n', ']e', vim.lsp.diagnostic.goto_next, bufopts)
    --  buf_set_keymap('n', '<leader>law', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    --  buf_set_keymap('n', '<leader>lrw', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    --  buf_set_keymap('n', '<leader>llw', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    --  buf_set_keymap('n', '<leader>lt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    --  buf_set_keymap('n', '<leader>lrn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    --  buf_set_keymap('n', '<leader>lrf', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    --  buf_set_keymap('n', '<leader>ld', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
    --  buf_set_keymap('n', '<leader>ll', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      -- default in neovim 0.7+
      debounce_text_changes = 150,
    }
  }
end,
})

--local function load_lsp_signature()
--  local loaded, lsp_signature = pcall(require, 'lsp_signature')
--  if loaded then
--    lsp_signature.on_attach {
--      bind = true,
--      hint_scheme = "String",
--      hint_prefix = "ƒ ",
--      use_lspsaga = false,
--      -- decorator = ["`", "`"],
--      handler_opts = {
--        border = 'single'
--      },
--    }
--  end
--end

--local function setup_servers()
--  local capabilities = vim.lsp.protocol.make_client_capabilities()

--  -- Code actions
--  capabilities.textDocument.codeAction = {
--    dynamicRegistration = false,
--    codeActionLiteralSupport = {
--      codeActionKind = {
--        valueSet = {
--          "",
--          "quickfix",
--          "refactor",
--          "refactor.extract",
--          "refactor.inline",
--          "refactor.rewrite",
--          "source",
--          "source.organizeImports",
--        },
--      }
--    }
--  }

--  -- Snippets
--  capabilities.textDocument.completion.completionItem.snippetSupport = true

--  -- LSPs

--  local servers = {}

--  if pcall(require, 'lspinstall') then
--    local lspinstall = require'lspinstall'
--    lspinstall.setup()
--    servers = lspinstall.installed_servers()
--  end

--  for _, lsp in ipairs(servers) do
--    -- auto configure lsp server
--    lspconfig[lsp].setup {
--      on_attach = on_attach,
--      capabilities = capabilities,
--      flags = {
--        debounce_text_changes = 150
--      },
--      init_options = {
--        onlyAnalyzeProjectsWithOpenFiles = true,
--        suggestFromUnimportedLibraries = false,
--        closingLabels = true,
--      }
--    }
--  end

--  -- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
--  -- lspinstall.post_install_hook = function()
--  --   setup_servers() -- reload installed servers
--  --   vim.cmd("bufdo e") -- triggers FileType autocmd that starts the server
--  -- end
--end

--local function on_attach(client, bufnr)
--  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
--  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

--  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

--  -- Mappings.
--  local opts = { noremap = true, silent = true }

--  buf_set_keymap('n', 'gA', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
--  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
--  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
--  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
--  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
--  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
--  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
--  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
--  buf_set_keymap('n', '<leader>law', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
--  buf_set_keymap('n', '<leader>lrw', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
--  buf_set_keymap('n', '<leader>llw', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
--  buf_set_keymap('n', '<leader>lt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
--  buf_set_keymap('n', '<leader>lrn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
--  buf_set_keymap('n', '<leader>lrf', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
--  buf_set_keymap('n', '<leader>ld', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
--  buf_set_keymap('n', '<leader>ll', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

--  -- Set some keybinds conditional on server capabilities
--  --
--  if client.resolved_capabilities.document_formatting then
--    buf_set_keymap("n", "<leader>lf", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
--  elseif client.resolved_capabilities.document_range_formatting then
--    buf_set_keymap("n", "<leader>lf", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
--  end

--  -- replace the default lsp diagnostic letters with prettier symbols
--  --
--  vim.fn.sign_define("LspDiagnosticsSignError", {text = "", numhl = "LspDiagnosticsDefaultError"})
--  vim.fn.sign_define("LspDiagnosticsSignWarning", {text = "", numhl = "LspDiagnosticsDefaultWarning"})
--  vim.fn.sign_define("LspDiagnosticsSignInformation", {text = "", numhl = "LspDiagnosticsDefaultInformation"})
--  vim.fn.sign_define("LspDiagnosticsSignHint", {text = "", numhl = "LspDiagnosticsDefaultHint"})

--  -- Set autocommands conditional on server_capabilities
--  --
--  if false and client.resolved_capabilities.document_highlight then
--    vim.cmd [[
--    hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
--    hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
--    hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow

--    augroup lsp_document_highlight
--    autocmd! * <buffer>
--    autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
--    autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
--    augroup END
--    ]]
--  end

--  load_lsp_signature()
--end

--setup_servers()
