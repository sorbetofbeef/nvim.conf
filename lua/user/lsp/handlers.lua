local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_cmp_ok then
	return
end

-- local status_cmp_ok, coq = pcall(require, "coq")
-- if not status_cmp_ok then
-- 	return
-- end

local km_status_ok, keymaps = pcall(require, "user.keymaps")
if not km_status_ok then
	return
end

local M = {}

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities.textDocument.completion.completionItem.additionalTextEdits = true
M.capabilities = cmp_nvim_lsp.update_capabilities(M.capabilities)
-- M.capabilities = coq.lsp_ensure_capabilities({M.capabilities})

--[[ local lsp_formatting = function(bufnr)
	vim.lsp.buf.format({
		filter = function(client)
			-- apply whatever logic you want (in this example, we'll only use null-ls)
			return client.name == "null-ls"
		end,
		bufnr = bufnr,
	})
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
]]
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
				prefix = "<-",
				-- prefix = " ●",
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
				prefix = "",
			},
		},
	}

	vim.diagnostic.config(config.diagnostic)

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, config.float)

	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, config.float)

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

--[[ local function attach_ariel()
  local status_ok, ariel = pcall(require, "ariel")
  if not status_ok then
    
  end
end ]]
local symbolHighlight = function(client, bufnr)
	if client.resolved_capabilities.document_highlight then
		vim.cmd([[
    hi! LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
    hi! LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
    hi! LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
  ]])
		vim.api.nvim_create_augroup("lsp_document_highlight", {
			clear = false,
		})
		vim.api.nvim_clear_autocmds({
			buffer = bufnr,
			group = "lsp_document_highlight",
		})
		vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
			group = "lsp_document_highlight",
			buffer = bufnr,
			callback = vim.lsp.buf.document_highlight,
		})
		vim.api.nvim_create_autocmd("CursorMoved", {
			group = "lsp_document_highlight",
			buffer = bufnr,
			callback = vim.lsp.buf.clear_references,
		})
	end
end

M.on_attach = function(client, bufnr)
	--[[ if client.supports_method("textDocument/formatting") then
		vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = augroup,
			buffer = bufnr,
			callback = function()
				lsp_formatting(bufnr)
			end,
		})
	end ]]

	--[[ if client.name == "tsserver" then
		client.server_capabilities.document_formatting = false
	end

	if client.name == "sumneko_lua" then
		client.server_capabilities.document_formatting = false
	end ]]

	if client.name == "rust_analyzer" then
		client.server_capabilities.experimental = true
	end

	keymaps.attach(client, bufnr)
	attach_navic(client, bufnr)
	attach_illuminate(client)
  symbolHighlight(client, bufnr)
end

-- function M.enable_format_on_save()
-- 	vim.cmd([[
--     augroup format_on_save
--       autocmd!
--       autocmd BufWritePre * lua vim.lsp.buf.format({ async = false })
--     augroup end
--   ]])
-- 	vim.notify("Enabled format on save")
-- end
--
-- function M.disable_format_on_save()
-- 	M.remove_augroup("format_on_save")
-- 	vim.notify("Disabled format on save")
-- end
--
-- function M.toggle_format_on_save()
-- 	if vim.fn.exists("#format_on_save#BufWritePre") == 0 then
-- 		M.enable_format_on_save()
-- 	else
-- 		M.disable_format_on_save()
-- 	end
-- end
--
-- function M.remove_augroup(name)
-- 	if vim.fn.exists("#" .. name) == 1 then
-- 		vim.cmd("au! " .. name)
-- 	end
-- end
--
-- vim.cmd([[ command! LspToggleAutoFormat execute 'lua require("user.lsp.handlers").toggle_format_on_save()' ]])

return M
