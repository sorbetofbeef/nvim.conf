local M = {}

M.setup = function (variant)
  vim.g.starry_italic_string = true
  vim.g.starry_italic_keywords = true
  vim.g.starry_italic_functions = true
  vim.g.starry_borders = true

  vim.cmd("colorscheme " .. variant)
end


return M
