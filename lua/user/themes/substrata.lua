local M = {}

M.setup = function(variant)
	local theme
	if variant == "light" then
		theme = "brighter"
	else
		theme = "default"
	end
	vim.g.substrata_variant = theme
	vim.g.substrata_italic_keywords = true
	vim.g.substrata_italic_functions = true
	vim.g.substrata_italic_booleans = true
	vim.g.substrata_italic_comments = true

	vim.cmd("colorscheme substrata")
end

return M
