return {
	"nvimdev/lspsaga.nvim",
	config = function()
		require("lspsaga").setup({
			symbol_in_winbar = {
				show_file = false,
				folder_level = 0,
				hide_keyword = true,
				color_mode = false,
				separator = "  ",
			},
			lightbulb = {
				enable = true,
				virtual_text = false,
			},
			ui = {
				code_action = "󰌶",
				border = "double",
			},
			finder = { methods = { tyd = "textDocument/typeDefinition" } },
			implement = {
				enable = true,
				sign = false,
				virtual_text = true,
			},
		})
	end,
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
	},
}
