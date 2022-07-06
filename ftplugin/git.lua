vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter"}, {
  pattern = { "./.git/*", ".gitignore", ".gitconfig" },
  command = "TabRename Git"
})
