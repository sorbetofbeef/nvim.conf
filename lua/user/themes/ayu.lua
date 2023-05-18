local M = {}

M.setup = function(variant)
	require("ayu").setup({
		mirage = false,
	})
	vim.o.background = variant
	vim.cmd("colorscheme ayu")
end

return M
