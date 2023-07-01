local M = {}

M.setup = function(variant)
	vim.g.nord_contrast = true
	vim.g.nord_borders = true
	vim.g.nord_disable_background = false
	vim.g.nord_italic = true
	vim.g.nord_bold = true

	require("headlines").setup({
		markdown = {
			headline_highlights = {
				"Headline1",
				"Headline2",
				"Headline3",
				"Headline4",
				"Headline5",
				"Headline6",
			},
			codeblock_highlight = "CodeBlock",
			dash_highlight = "Dash",
			quote_highlight = "Quote",
		},
	})

	vim.opt.background = variant
	require("nord").set()
end

return M
