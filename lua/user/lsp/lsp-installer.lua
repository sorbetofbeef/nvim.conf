local status_ok, mason = pcall(require, "mason")
if not status_ok then
	return
end

local lsp_status_ok, mason_config = pcall(require, "mason-lspconfig")
if not lsp_status_ok then
	return
end

local mason_null_ok, mason_null = pcall(require, "mason-null-ls")
if not mason_null_ok then
	return
end

local servers = {
	"gopls",
	"cssls",
	"html",
	"pyright",
	"bashls",
	"jsonls",
	"yamlls",
	"taplo",
	"marksman",
	"sqls",
	"emmet_ls",
	"dockerls",
	"vimls",
	"graphql",
	"svelte",
	"tailwindcss",
	"tsserver",
	"dartls",
	"rust_analyzer",
	"sumneko_lua",
}

local mason_servers = {
	"gopls",
	"sumneko_lua",
	"cssls",
	"html",
	"pyright",
	"bashls",
	"jsonls",
	"yamlls",
	"taplo",
	"marksman",
	"sqls",
	"emmet_ls",
	"dockerls",
	"vimls",
	"graphql",
	"svelte",
	"tailwindcss",
}

mason.setup({})

local luadev_ok, neodev = pcall(require, "neodev")
if not luadev_ok then
	return
end
neodev.setup()

mason_config.setup({
	ensure_installed = mason_servers,
})

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
	return
end

local opts = {}

for _, server in pairs(servers) do
	local handler = require("user.lsp.handlers")

	opts = {
		on_attach = handler.on_attach,
		capabilities = handler.capabilities,
	}

	if server == "sumneko_lua" then
		local sumneko_opts = require("user.lsp.settings.sumneko_lua")
		opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
	end

	if server == "pyright" then
		local pyright_opts = require("user.lsp.settings.pyright")
		opts = vim.tbl_deep_extend("force", pyright_opts, opts)
	end

	if server == "rust_analyzer" then
		require("user.lsp.settings.rust")
		goto continue
	end

	if server == "tsserver" then
		require("user.lsp.settings.tsserver")
		goto continue
	end

	if server == "dartls" then
		require("user.lsp.flutter_tools")
		goto continue
	end

	if server == "gopls" then
		local gopls_opts = require("user.lsp.settings.gopls")
		opts = vim.tbl_deep_extend("force", gopls_opts, opts)
	end

	if server == "sqls" then
		local sqls_opts = require("user.lsp.settings.sqls")
		opts = vim.tbl_deep_extend("force", sqls_opts, opts)
	end

	if server == "jsonls" then
		local jsonls_opts = require("user.lsp.settings.jsonls")
		opts = vim.tbl_deep_extend("force", jsonls_opts, opts)
	end

	if server == "tsserver" then
		local tsserver_opts = require("user.lsp.settings.tsserver")
		opts = vim.tbl_deep_extend("force", tsserver_opts, opts)
	end

	lspconfig[server].setup(opts)
	::continue::
end

local null_install = {
	"prettierd",
	"black",
	"stylua",
	"gofumpt",
	"shellharden",
	"taplo",
	"tidy",
	"eslint_d",
	"prettierd",
	"shellcheck",
	"flake8",
	"revive",
}

local null_status_ok, null_ls = pcall(require, "user.lsp.null-ls")
if not null_status_ok then
	return
end

null_ls.setup()

mason_null.setup({
	ensure_installed = null_install,
	automatic_inststallation = true,
})
