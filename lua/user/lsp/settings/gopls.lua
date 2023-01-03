--[[ local status_ok, lsp = pcall(require, "lspconfig")
if not status_ok then
  return
end

local handlers = require('lsp.handlers')

lsp.gopls.setup{ ]]

return {
	cmd = { "gopls" },
	settings = {
		gopls = {
			analyses = {
				nilness = true,
				unsusedparams = true,
				unusedwrite = true,
				useany = true,
			},
			hints = {
				assignVariableTypes = true,
				compositeLiteralFields = true,
				constantValues = true,
				functionTypeParameters = true,
				parameterNames = true,
				rangeVariableTypes = true,
			},
			experimentalPostfixCompletions = true,
			gofumpt = true,
			staticcheck = true,
			usePlaceholders = true,
		},
	},
}
