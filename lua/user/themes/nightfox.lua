local M = {}

M.setup = function(variant)
	local theme = ""

	if variant == "dark" then
		theme = "nightfox"
	else
		theme = variant
	end
	require("nightfox").setup({
		options = {
			-- Compiled file's destination location
			-- compile_path = vim.fn.stdpath("cache") .. "/nightfox",
			-- compile_file_suffix = "_compiled", -- Compiled file suffix
			transparent = false, -- Disable setting background
			terminal_colors = true, -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
			dim_inactive = true, -- Non focused panes set to alternative background
			styles = { -- Style to be applied to different syntax groups
				comments = "italic", -- Value is any valid attr-list value `:help attr-list`
				conditionals = "NONE",
				constants = "italic,bold",
				functions = "italic",
				keywords = "bold",
				numbers = "NONE",
				operators = "NONE",
				strings = "italic",
				types = "bold",
				variables = "bold",
			},
			inverse = { -- Inverse highlight for different types
				match_paren = false,
				visual = false,
				search = false,
			},
			modules = {
				aerial = false,
				barbar = false,
				cmp = true,
				dap_ui = true,
				dashboard = false,
				diagnostic = {
					enable = true,
					background = true,
				},
				fern = false,
				fidget = false,
				gitgutter = true,
				gitsigns = true,
				glyph_palette = true,
				hop = false,
				illuminate = true,
				lightspeed = false,
				lsp_saga = false,
				lsp_trouble = true,
				modes = true,
				native_lsp = true,
				neogit = true,
				neotree = false,
				notify = false,
				nvimtree = true,
				pounce = false,
				sneak = false,
				symbol_outline = true,
				telescope = true,
				treesitter = true,
				tsrainbow = false,
				whichkey = true,
			},
		},
	})

	vim.cmd("colorscheme " .. theme)
end

return M
