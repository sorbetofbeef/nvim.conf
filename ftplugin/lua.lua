vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter"}, {
  pattern = { "*.lua" },
  command = "TabRename Lua"
})
