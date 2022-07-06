vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter"}, {
  pattern = { "*.go", "gohtmltmpl", "*.gotexttmpl", "*.gotmpl", "go.mod" },
  command = "TabRename Go"
})
