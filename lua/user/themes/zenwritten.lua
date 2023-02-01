local M = {}

M.setup = function(variant)
	vim.opt.background = variant
	vim.cmd("colorscheme zenwritten")
end

return M
