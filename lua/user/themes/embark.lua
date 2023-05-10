local M = {}

M.setup = function(varient)
	vim.opt.background = varient
	vim.g.embark_terminal_italics = true
	vim.cmd("colorscheme embark")
end

return M
