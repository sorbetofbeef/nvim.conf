vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter"}, {
  pattern = { "*.rs" },
  command = "TabRename Rust"
})
