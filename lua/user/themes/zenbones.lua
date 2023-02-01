local M = {}

M.setup = function(variant)
	vim.opt.background = variant
	vim.cmd("colorscheme zenbones")
end

return M
