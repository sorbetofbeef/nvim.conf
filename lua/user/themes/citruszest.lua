M = {}

M.setup = function(variant)
	require("citruszest").setup({
		transparency = false,
	})
	vim.opt.background = variant
	vim.cmd("colorscheme citruszest")
end

return M
