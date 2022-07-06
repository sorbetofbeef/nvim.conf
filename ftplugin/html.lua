vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter"}, {
  pattern = { "*.html", "*.js", "*.jsx", "*.ts", "*.tsx", "*.css", "*.scss" },
  command = "TabRename Web"
})
