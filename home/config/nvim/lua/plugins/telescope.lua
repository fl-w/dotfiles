local loaded, telescope = pcall(require, 'telescope')

if not loaded then
  return
end

-- require('telescope').load_extension('fzy_native')
telescope.setup {
  extensions = {
    media_files = {
      -- filetypes whitelist
      -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
      filetypes = {"png", "webp", "jpg", "jpeg"},
      find_cmd = "rg" -- find command (defaults to `fd`)
    }
  },
}
