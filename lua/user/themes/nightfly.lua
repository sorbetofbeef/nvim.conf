local M = {}

M.setup = function(varient)
	vim.opt.background = varient
	vim.g.nightflyCursorColor = true
	vim.g.nightflyItalics = true
	vim.g.nightflyNormalFloat = true
	vim.g.nightflyUnderlineMatchParen = true
	vim.g.nightflyWinSeparator = 2
	vim.opt.fillchars = {
		horiz = "━",
		horizup = "┻",
		horizdown = "┳",
		vert = "┃",
		vertleft = "┫",
		vertright = "┣",
		verthoriz = "╋",
	}

	vim.cmd([[colorscheme nightfly]])
end

return M
