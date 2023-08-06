local km_status_ok, keymaps = pcall(require, "user.keymaps")
if not km_status_ok then
	return
end

local M = {}

local common_capabilities = function()
	local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
	if status_ok then
		return cmp_nvim_lsp.default_capabilities()
	end

	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities.textDocument.completion.completionItem.snippetSupport = true
	capabilities.textDocument.completion.completionItem.resolveSupport = {
		properties = {
			"documentation",
			"detail",
			"additionalTextEdits",
		},
	}

	return capabilities
end

M.capabilities = common_capabilities()

M.setup = function()
	local signs = {
		{ name = "DiagnosticSignError", text = " " },
		{ name = "DiagnosticSignWarn", text = " " },
		{ name = "DiagnosticSignHint", text = " " },
		{ name = "DiagnosticSignInfo", text = " " },
	}

	for _, sign in ipairs(signs) do
		vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
	end

	local config = {
		float = {
			focusable = true,
			style = "minimal",
			border = "rounded",
		},
		diagnostic = {
			-- virtual_text = false,
			virtual_text = {
				spacing = 7,
				update_in_insert = false,
				severity_sort = true,
				prefix = "<-   ",
				source = "if_many", -- Or "always"
				-- format = function(diag)
				--   return diag.message .. "blah"
				-- end,
			},
			signs = true,
			active = true,
			underline = true,
			severity_sort = true,
			float = {
				focusable = true,
				style = "minimal",
				border = "rounded",
				source = "if_many",
				header = "",
				prefix = "  ",
			},
		},
	}

	vim.diagnostic.config(config.diagnostic)

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, config.float)
	vim.lsp.handlers["textDocument/publishDiagnostics"] =
		vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, config.diagnostic)
end

local function attach_illuminate(client)
	local status_ok, illuminate = pcall(require, "illuminate")
	if not status_ok then
		return
	end
	illuminate.on_attach(client)
end

M.on_attach = function(client, bufnr)
	if client.name == "rust_analyzer" then
		client.server_capabilities.experimental = true
		require("user.keymaps").rust_maps(bufnr)
	end

	require("sqls").on_attach(client, bufnr)
	require("user.keymaps").sqls_maps(bufnr)

	if client.name == "gopls" then
		require("user.keymaps").go_keymaps(bufnr)
	end

	if client.name == "tsserver" then
		require("user.keymaps").ts_maps(bufnr)
		client.server_capabilities.documentFormattingProvider = false
	end

	if client.name == "sumneko_lua" then
		client.server_capabilities.documentFormattingProvider = false
	end

	if client.name == "cssmodules_ls" then
		client.server_capabilities.definitionProvider = false
	end

	keymaps.attach(client, bufnr)
	attach_illuminate(client)
end

return M
