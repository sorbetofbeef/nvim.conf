local status_ok, mason = pcall(require, "mason")
if not status_ok then
	return
end

local lsp_status_ok, mason_config = pcall(require, "mason-lspconfig")
if not lsp_status_ok then
	return
end


local servers = {
	"gopls",
	"sumneko_lua",
	"cssls",
	"html",
	"tsserver",
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
	"dartls",
  "rust_analyzer"
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
}

mason.setup({})
mason_config.setup({
  ensure_installed = mason_servers
})

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
	return
end


local opts = {}

for _, server in pairs(servers) do
	opts = {
		on_attach = require("user.lsp.handlers").on_attach,
		capabilities = require("user.lsp.handlers").capabilities,
	}

	if server == "sumneko_lua" then
    local luadev_ok, neodev = pcall(require, "neodev")
    if not luadev_ok then
      return
    end
    neodev.setup()
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
