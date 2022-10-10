local M = {}
M.setup = function(variant)
  vim.opt.termguicolors = true
  vim.opt.background = variant
  vim.cmd("colorscheme melange")
end
return M
