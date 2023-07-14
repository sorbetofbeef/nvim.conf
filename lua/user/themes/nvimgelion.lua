local M = {}

M.setup = function(variant)
	vim.cmd("colorscheme nvimgelion")
	vim.opt.background = variant
end

return M
