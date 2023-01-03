local M = {}

M.setup = function(variant)
	vim.g.material_style = variant

	require("material").setup({
		contrast = {
			terminal = true,
			sidebars = true,
			floating_windows = true,
			cursor_line = true,
			non_current_windows = true,
			filetypes = {
				"Outline",
				"neo-tree",
				-- "NvimTree",
				"dapui_scopes",
				"dapui_stacks",
				"dapui_watches",
				"dapui_breakpoints",
				"dapui-repl",
				"dapui_console",
			},
		},
		styles = {
			comments = { italic = true }, -- Enable italic comments
			keywords = { bold = true }, -- Enable italic keywords
			functions = { standout = true, italic = true }, -- Enable italic functions
			strings = { italic = true }, -- Enable italic strings
			variables = { bold = true }, -- Enable italic variables
		},
		disable = {
			background = false,
			term_colors = false,
			eob_lines = false,
		},
		plugins = { -- Here, you can disable(set to false) plugins that you don't use or don't want to apply the theme to
			trouble = true,
			nvim_cmp = true,
			neogit = true,
			gitsigns = true,
			git_gutter = true,
			telescope = true,
			nvim_tree = true,
			sidebar_nvim = true,
			lsp_saga = true,
			nvim_dap = true,
			nvim_navic = true,
			which_key = true,
			sneak = true,
			hop = true,
			indent_blankline = true,
			nvim_illuminate = true,
			mini = true,
		},
	})

	vim.cmd("colorscheme material")
end

return M
