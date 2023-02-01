return {
	cmd = { "gopls" },
	settings = {
		{
			-- more settings: https://github.com/golang/tools/blob/master/gopls/doc/settings.md
			-- flags = {allow_incremental_sync = true, debounce_text_changes = 500},
			-- not supported
			analyses = {
				unusedparams = true,
				unreachable = false,
				unusedwrite = true,
				useany = true,
			},
			codelenses = {
				generate = true, -- show the `go generate` lens.
				gc_details = true, --  // Show a code lens toggling the display of gc's choices.
				test = true,
				tidy = true,
			},
			hints = {
				assignVariableTypes = true,
				compositeLiteralFields = true,
				constantValues = true,
				functionTypeParameters = true,
				parameterNames = true,
				rangeVariableTypes = true,
			},
			usePlaceholders = true,
			completeUnimported = true,
			staticcheck = true,
			matcher = "fuzzy",
			diagnosticsDelay = "500ms",
			experimentalWatchedFileDelay = "100ms",
			symbolMatcher = "fuzzy",
			experimentalPostfixCompletions = true,
			gofumpt = false, -- true, -- turn on for new repos, gofmpt is good but also create code turmoils
			buildFlags = { "-tags", "integration" },
			-- buildFlags = {"-tags", "functional"}
		},
	},
}
