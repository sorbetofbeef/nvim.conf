local M = {}

M.setup = function (variant)

  vim.g.aqua_bold = true
  vim.g.aquarium_style = variant

  vim.cmd("colorscheme aquarium")
end

return M
