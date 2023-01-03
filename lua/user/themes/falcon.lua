local M = {}
M.setup = function(_)
	vim.g.falcon_background = true
	vim.g.falcon_inactive = true

	vim.cmd("colorscheme falcon")
end
return M
