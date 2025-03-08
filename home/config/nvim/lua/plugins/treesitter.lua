local loaded, treesitter = pcall(require, 'nvim-treesitter.configs')

if not loaded then
  return
end

treesitter.setup {
  ensure_installed = {
    "bash",
    "html",
    -- "javascript",
    "json",
    "lua",
    "markdown",
    "markdown_inline",
    "python",
    "kotlin",
    "query",
    "regex",
    "rust",
    "tsx",
    "typescript",
    "vim",
    "yaml",
  },
  indent = { enable = false },
  highlight = {
    enable = false,
    use_languagetree = false
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
  textobjects = {
    select = {
      enable = true,

      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,

      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",

        -- Or you can define your own textobjects like this
        ["iF"] = {
          python = "(function_definition) @function",
          cpp = "(function_definition) @function",
          c = "(function_definition) @function",
          java = "(method_declaration) @function",
        },
      },
    },
  },
}

require("nvim-treesitter.install").compilers = { "gcc", "clang", "cl" }
