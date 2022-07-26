local map_status_ok, map = pcall(require, "user.keymaps")
local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_cmp_ok then
	return
end

local M = {}

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities.textDocument.completion.completionItem.additionalTextEdits = true
M.capabilities = cmp_nvim_lsp.update_capabilities(M.capabilities)

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
      border = "rounded"
    },
    diagnostic = {
      virtual_text = true, -- disable virtual text
      signs = true,
      update_in_insert = false,
      underline = true,
      severity_sort = true,
      float = {
        focusable = true,
        style = "minimal",
        border = "rounded"
      }
    }
	}

	vim.diagnostic.config(config.diagnostic)
	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, config.float)

	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, config.float)

  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, config.diagnostic)
end

local g_keymaps = function(bufnr)
  if not map_status_ok then
    return
  end

  map.lsp_g_keymaps(bufnr)
end

local l_keymaps = function(bufnr)
  if not map_status_ok then
    return
  end

  map.lsp_l_keymaps(bufnr)
end

local rust_doc_mapping = function(bufnr)
  if not map_status_ok then
    return
  end

  map.rust_doc_mapping(bufnr)
end

local go_keymaps = function(bufnr)
  if not map_status_ok then
    return
  end

  map.go_keymaps(bufnr)
end

local go_doc_mapping = function(bufnr)
  if not map_status_ok then
    return
  end

  map.go_doc_mapping(bufnr)
end

local doc_mapping = function(bufnr)
  if not map_status_ok then
    return
  end

  map.lsp_doc_mapping(bufnr)
end

local function attach_navic(client, bufnr)
  vim.g.navic_silence = true
  local status_ok, navic = pcall(require, "nvim-navic")
  if not status_ok then
    return
  end
  navic.attach(client, bufnr)
end

--[[ local function attach_ariel()
  local status_ok, ariel = pcall(require, "ariel")
  if not status_ok then
    
  end
end ]]

M.on_attach = function(client, bufnr)
  attach_navic(client, bufnr)

	if client.name == "tsserver" then
		client.server_capabilities.document_formatting = false
	end

	if client.name == "sumneko_lua" then
		client.server_capabilities.document_formatting = false
	end

	if client.name == "rust_analyzer" then
		client.server_capabilities.experimental = true
	end

	g_keymaps(bufnr)
	l_keymaps(bufnr)

	if client.name == "rust_analyzer" then
		rust_doc_mapping(bufnr)
	elseif client.name == "gopls" then
		go_keymaps(bufnr)
		go_doc_mapping(bufnr)
	else
		doc_mapping(bufnr)
	end

	local status_ok, illuminate = pcall(require, "illuminate")
	if not status_ok then
		return
	end
	illuminate.on_attach(client)
end

return M
