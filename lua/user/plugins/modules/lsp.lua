return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"jay-babu/mason-null-ls.nvim",
			"j-hui/fidget.nvim",
			"folke/neodev.nvim",
			"RRethy/vim-illuminate",
			"hrsh7th/cmp-nvim-lsp",
			"mfussenegger/nvim-dap",
		},
		config = function()
			local servers = {
				"cssls",
				"html",
				"pyright",
				"bashls",
				"jsonls",
				"yamlls",
				"taplo",
				"marksman",
				"sqlls",
				"emmet_ls",
				"dockerls",
				"vimls",
				"graphql",
				"svelte",
				"tailwindcss",
				"tsserver",
				"dartls",
				"rust_analyzer",
				"lua_ls",
				"gopls",
			}

			local mason_servers = {
				"lua_ls",
				"cssls",
				"html",
				"pyright",
				"bashls",
				"jsonls",
				"yamlls",
				"taplo",
				"marksman",
				"sqlls",
				"emmet_ls",
				"dockerls",
				"tsserver",
				"vimls",
				"graphql",
				"svelte",
				"tailwindcss",
				"gopls",
			}

			require("mason").setup({})

			local luadev_ok, neodev = pcall(require, "neodev")
			if not luadev_ok then
				return
			end
			neodev.setup()

			require("mason-lspconfig").setup({
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

				if server == "lua_ls" then
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
					require("user.lsp.settings.go")
					goto continue
				end

				if server == "sqlls" then
					local sqlls_opts = require("user.lsp.settings.sqls")
					opts = vim.tbl_deep_extend("force", sqlls_opts, opts)
				end

				if server == "jsonls" then
					local jsonls_opts = require("user.lsp.settings.jsonls")
					opts = vim.tbl_deep_extend("force", jsonls_opts, opts)
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
				"shellcheck",
				"flake8",
				"revive",
			}

			require("mason-null-ls").setup({
				ensure_installed = null_install,
				automatic_inststallation = true,
			})

			require("null-ls").setup()

			vim.fn.sign_define(
				"DapBreakpoint",
				{ text = "", texthl = "DiagnosticSignError", linehl = "", numhl = "" }
			)

			require("dap").listeners.after.event_initialized["dapui_config"] = function()
				require("dapui").open({})
			end

			require("dap").listeners.before.event_terminated["dapui_config"] = function()
				require("dapui").close({})
			end

			require("dap").listeners.before.event_exited["dapui_config"] = function()
				require("dapui").close({})
			end
		end,
	},
	{
		"jose-elias-alvarez/null-ls.nvim",
		-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
		config = function()
			local formatting = require("null-ls").builtins.formatting
			-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
			local diagnostics = require("null-ls").builtins.diagnostics
			local actions = require("null-ls").builtins.code_actions
			-- local complete = null_ls.builtins.completion

			-- https://github.com/prettier-solidity/prettier-plugin-solidity

			local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
			require("null-ls").setup({
				on_attach = function(current_client, bufnr)
					if current_client.supports_method("textDocument/formatting") then
						vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
						vim.api.nvim_create_autocmd("BufWritePre", {
							group = augroup,
							buffer = bufnr,
							callback = function()
								vim.lsp.buf.format({
									filter = function(client)
										return client.name == "null-ls"
									end,
									bufnr = bufnr,
								})
							end,
						})
					end
				end,

				debug = false,

				sources = {
					formatting.prettier,
					formatting.eslint_d.with({
						command = "eslint_d",
						args = { "--fix-to-stdout", "--stdin", "--stdin-filename", "$FILENAME" },
					}),
					formatting.black.with({ extra_args = { "--quiet", "--fast" } }),
					formatting.stylua,
					formatting.gofumpt,
					formatting.taplo,
					formatting.tidy,
					formatting.djlint.with({
						filetypes = { "django", "jinja.html", "htmldjango", "gohtmltmpl", "gotexttmpl" },
						command = "djlint",
						args = { "--reformat", "-" },
					}),
					actions.eslint_d.with({
						command = "eslint_d",
						args = { "-f", "json", "--stdin", "--stdin-filename", "$FILENAME" },
					}),
					-- actions.refactoring,
					diagnostics.eslint_d.with({
						command = "eslint_d",
						args = { "-f", "json", "--stdin", "--stdin-filename", "$FILENAME" },
					}),
					diagnostics.flake8,
					diagnostics.revive,
					diagnostics.tidy,
					diagnostics.shellcheck,
				},
			})
		end,
	},
}
