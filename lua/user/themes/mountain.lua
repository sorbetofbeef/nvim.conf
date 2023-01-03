local M = {}
M.setup = function(variant)
	require("mellifluous").setup({ --[[...]]
		dim_inactive = true,
		color_set = "mellifluous",
		styles = {
			comments = "italic",
			conditionals = "bold",
			folds = "bold",
			loops = "bold",
			functions = "italic",
			booleans = "bold",
			keywords = "NONE",
			strings = "NONE",
			variables = "bold",
			numbers = "NONE",
			properties = "NONE",
			types = "bold",
			operators = "NONE",
		},
		transparent_background = {
			enabled = false,
			floating_windows = false,
			telescope = true,
			file_tree = true,
			cursor_line = true,
			status_line = false,
		},
		plugins = {
			cmp = true,
			gitsigns = true,
			indent_blankline = true,
			nvim_tree = {
				enabled = true,
				show_root = false,
			},
			telescope = {
				enabled = true,
				nvchad_like = true,
			},
			startify = true,
		},
	}) -- optional, see configuration section.
	vim.opt.background = variant
	vim.cmd("colorscheme mellifluous")
end

return M
