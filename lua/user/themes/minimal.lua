local M = {}

M.setup = function(_)
  vim.g.minimal_itaic_comments = true
  vim.g.minimal_itaic_functions = true
  vim.g.minimal_itaic_keywords = true
  vim.g.minimal_itaic_booleans = true
  vim.g.minimal_itaic_variables = false

  vim.cmd("colorscheme minimal")
end

return M
