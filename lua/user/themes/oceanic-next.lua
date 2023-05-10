local M = {}

M.setup = function(varient)
	vim.opt.background = varient

	vim.g.oceanic_next_terminal_bold = true
	vim.g.oceanic_next_terminal_italic = true
	vim.cmd("colorscheme OceanicNext")
end

return M
