local loaded, compe = pcall(require, 'compe')

if loaded then
    vim.o.completeopt = "menuone,noselect"
    compe.setup {
        enabled = true,
        autocomplete = true,
        debug = false,
        min_length = 2,
        preselect = "enable",
        throttle_time = 80,
        source_timeout = 200,
        incomplete_delay = 400,
        max_abbr_width = 100,
        max_kind_width = 100,
        max_menu_width = 100,
        documentation = true,
        source = {
            buffer = {kind = "﬘", true},
            luasnip = {kind = "﬌", true},
            nvim_lsp = true,
            nvim_lua = true,
            ultisnips = true
        }
    }
    vim.api.nvim_set_keymap("i",
        "<CR>",
        "compe#confirm({ 'keys': '<CR>', 'select': v:true })",
        { expr = true }
    )
end
