local M = {}

M.setup = function(variant)
	vim.opt.laststatus = 3

	vim.opt.fillchars:append({
		horiz = "═",
		horizup = "╩",
		horizdown = "╦",
		vert = "║",
		vertleft = "╣",
		vertright = "╠",
		verthoriz = "╬",
	})

	require("kanagawa").setup({
		undercurl = true, -- enable undercurls
		commentStyle = { italic = true },
		functionStyle = { italic = true, bold = true },
		keywordStyle = { bold = true },
		statementStyle = {},
		typeStyle = { bold = true },
		variablebuiltinStyle = { bold = true },
		specialReturn = true, -- special highlight for the return keyword
		specialException = true, -- special highlight for exception handling keywords
		transparent = false, -- do not set background color
		dimInactive = true, -- dim inactive window `:h hl-NormalNC`
		globalStatus = true, -- adjust window separators highlight for laststatus=3
		colors = {},
		theme = variant,
	})

	vim.cmd("colorscheme kanagawa")
end

return M
