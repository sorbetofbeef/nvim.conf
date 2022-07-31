local M = {}

M.starry_setup = function () {
  vim.g.starry_italic_string = true
  vim.g.starry_italic_keywords = true
  vim.g.starry_italic_functions = true
  vim.g.starry_borders = true
  M.colorscheme = "limestone"
}

return M
