return {
	"pmizio/typescript-tools.nvim",
	dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
	config = function()
		local handlers = require("user.lsp.handlers")
		require("typescript-tools").setup({
			on_attach = handlers.on_attach,
			settings = {
				separate_diagnostic_server = true,
				publish_diagnostic_on = "insert_leave",
				tsserver_max_memory = "auto",
			},
		})
	end,
}
