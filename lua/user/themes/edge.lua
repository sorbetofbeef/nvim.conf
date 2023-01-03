local M = {}

M.setup = function(variant)
	vim.opt.background = "dark"
	local style
	if variant == "dark" then
		style = "default"
	end
	if variant == "light" then
		style = "default"
		vim.opt.background = "light"
	end
	if variant == "neon" then
		style = "neon"
	end
	if variant == "aurora" then
		style = "aurora"
	end

	local g = vim.g
	g.edge_style = style
	g.edge_dim_foreground = true
	g.edge_enable_italic = true
	g.edge_diagnostic_line_highlight = true
	g.edge_better_performance = true

	vim.cmd("colorscheme edge")
end

return M
