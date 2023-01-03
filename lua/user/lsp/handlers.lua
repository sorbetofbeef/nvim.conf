local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_cmp_ok then
	return
end

local km_status_ok, keymaps = pcall(require, "user.keymaps")
if not km_status_ok then
	return
end

local M = {}

M.capabilities = vim.lsp.protocol.make_client_capabilities()

M.capabilities.textDocument.completion.completionItem = {
	snippetSupport = true,
	additionalTextEdits = true,
}

M.capabilities = cmp_nvim_lsp.default_capabilities(M.capabilities)

M.setup = function()
	local signs = {
		{ name = "DiagnosticSignError", text = " " },
		{ name = "DiagnosticSignWarn", text = " " },
		{ name = "DiagnosticSignHint", text = " " },
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

local function attach_navic(client, bufnr)
	vim.g.navic_silence = true
	local status_ok, navic = pcall(require, "nvim-navic")
	if not status_ok then
		return
	end
	navic.attach(client, bufnr)
end

local function attach_illuminate(client)
	local status_ok, illuminate = pcall(require, "illuminate")
	if not status_ok then
		return
	end
	illuminate.on_attach(client)
end

local attach_inlay_hints = function(client, bufnr)
	local ok, hints = pcall(require, "lsp-inlayhints")
	if not ok then
		return
	end

	hints.setup()
	hints.on_attach(client, bufnr, true)
end

local attach_tab_name = function(client, bufnr, tabid, types)
	local okay, tab_name = pcall(require, "tabby.feature.tab_name")
	if not okay then
		return
	end
	if bufnr ~= vim.api.nvim_get_current_buf() then
		return
	end
	local tabname

	for client_name, title_string in pairs(types) do
		if (client.name == "tsserver") or (client.name == "tailwindcss") then
			if vim.filetype == "javascript" or "javascriptreact" or "javascript.jsx" then
				tabname = types.javascript
				break
			end
			if vim.filetype == "typescript" or "typescript.tsx" or "typescriptreact" then
				tabname = types.typescript
				break
			end
		end
		if (client.name == "marksman") or (client.name == "tailwindcss") then
			if vim.filetype == "markdown" then
				tabname = types.marksman
				break
			end
		end

		if client.name == client_name then
			tabname = title_string
			break
		end

		if client.name ~= client_name then
			tabname = " "
			break
		end
	end

	if vim.lsp.buf_is_attached(bufnr, client.id) then
		tab_name.set(tabid, tabname)
	else
		tabname = " "
		tab_name.set(tabid, tabname)
	end
end

M.crumb_name = ""

local attach_bread_crumb_filetype = function(client, bufnr, clients)
	if bufnr ~= vim.api.nvim_get_current_buf() then
		return
	end
	local filetype

	for client_name, title_string in pairs(clients) do
		if (client.name == "tsserver") or (client.name == "tailwindcss") then
			if vim.filetype == "javascript" or "javascriptreact" or "javascript.jsx" then
				filetype = clients.javascript
				break
			end
			if vim.filetype == "typescript" or "typescript.tsx" or "typescriptreact" then
				filetype = clients.typescript
				break
			end
		end
		if (client.name == "marksman") or (client.name == "tailwindcss") then
			filetype = clients.marksman
			break
		end

		if client.name == client_name then
			filetype = title_string
			break
		end

		if client.name ~= client_name then
			filetype = "Text"
			break
		end
	end

	if vim.lsp.buf_is_attached(bufnr, client.id) then
		M.crumb_name = filetype
	else
		local unknown = "Text"
		M.crumb_name = unknown
	end
end

M.on_attach = function(client, bufnr)
	if client.name == "rust_analyzer" then
		client.server_capabilities.experimental = true
	end

	local client_icons = {
		sumneko_lua = " ",
		bashls = " ",
		pyright = " ",
		jsonls = " ",
		gopls = " ",
		rust_analyzer = " ",
		dartls = " ",
		taplo = "TO",
		yamlls = "YA",
		javascript = " ",
		typescript = " ",
		marksman = " ",
	}

	local client_names = {
		sumneko_lua = "Lua",
		bashls = "Shell",
		pyright = "Python",
		jsonls = "JSON",
		gopls = "Go",
		rust_analyzer = "Rust",
		dartls = "Flutter/Dart",
		taplo = "TOML",
		yamlls = "YAML",
		javascript = "Javascript",
		typescript = "Typescript",
		marksman = "Markdown",
	}

	local filetype_icons = {
		lua = " ",
		shell = " ",
		python = " ",
		json = " ",
		go = " ",
		rust = " ",
		dart = " ",
		toml = "TO",
		yaml = "YA",
		javascript = " ",
		typescript = " ",
		markdown = " ",
	}

	local filetype_names = {
		lua = "Lua",
		shell = "Shell",
		python = "Python",
		json = "JSON",
		go = "Go",
		rust = "Rust",
		dart = "Flutter/Dart",
		toml = "TOML",
		yaml = "YAML",
		javascript = "Javascript",
		typescript = "Typescript",
		markdown = "Markdown",
	}

	local tab_id = require("tabby.module.api").get_current_tab

	-- attach_tab_name(client, bufnr, tab_id(), filetype_icons)
	-- attach_bread_crumb_filetype(client, bufnr, filetype_names)
	keymaps.attach(client, bufnr)
	attach_navic(client, bufnr)
	attach_illuminate(client)
	attach_inlay_hints(client, bufnr)
end

return M
