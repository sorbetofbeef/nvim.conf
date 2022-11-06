local M = {}
M.setup = function (_)
  vim.g.mellow_italic_comments = true
  vim.g.mellow_italic_keywords = false
  vim.g.mellow_italic_booleans = true
  vim.g.mellow_italic_functions =	true
  vim.g.mellow_italic_variables =	false
  vim.g.mellow_bold_comments = false
  vim.g.mellow_bold_keywords = true
  vim.g.mellow_bold_booleans = false
  vim.g.mellow_bold_functions =	true
  vim.g.mellow_bold_variables =	true
  vim.g.mellow_transparent = false

  vim.cmd("colorscheme mellow")
end

return M
