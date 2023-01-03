return {
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
			completion = {
				callSnippet = "Replace",
			},
			workspace = {
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.stdpath("config") .. "/lua"] = true,
				},
				maxPreload = 2000,
				preloadFileSize = 50000,
				checkThirdParty = false,
			},
			telemetry = {
				enable = false,
			},
		},
	},
}
