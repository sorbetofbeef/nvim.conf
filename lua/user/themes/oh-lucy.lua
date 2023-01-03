local M = {}

M.setup = function(variant)
	if variant == "evening" then
		vim.g.oh_lucy_evening_italic_functions = true
		vim.g.oh_lucy_evening_italic_variables = false
		vim.g.oh_lucy_evening_italic_functions = true
		vim.cmd([[colorscheme oh-lucy-evening]])
	else
		vim.g.oh_lucy_italic_functions = true
		vim.g.oh_lucy_italic_variables = false
		vim.g.oh_lucy_italic_functions = true
		vim.cmd([[colorscheme oh-lucy]])
	end
end

return M
