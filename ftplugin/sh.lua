vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter"}, {
  pattern = { "*.sh" },
  command = "TabRename Shell Script"
})
