local M = {}

M.setup = function(variant)
	require("nord").setup({
		transparent = false, -- Enable this to disable setting the background color
		terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
		diff = { mode = "bg" }, -- enables/disables colorful backgrounds when used in diff mode. values : [bg|fg]
		borders = true, -- Enable the border between verticaly split windows visible
		errors = { mode = "bg" }, -- Display mode for errors and diagnostics
		-- values : [bg|fg|none]
		styles = {
			-- Style to be applied to different syntax groups
			-- Value is any valid attr-list value for `:help nvim_set_hl`
			comments = { italic = true },
			keywords = {},
			functions = {},
			variables = {},
		},
	})

	vim.opt.background = variant
	vim.cmd([[colorscheme nord]])
end

return M
