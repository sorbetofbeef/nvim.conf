local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics
local actions = null_ls.builtins.code_actions
-- local complete = null_ls.builtins.completion

-- https://github.com/prettier-solidity/prettier-plugin-solidity
local M = {}

M.setup = function()
	local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
	null_ls.setup({
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
			formatting.prettier_d_slim,
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
end

return M
