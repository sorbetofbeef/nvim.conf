local ok, lush = pcall(require, "lush")
if not ok then
	return
end

local M = {}

M.setup = function(variant)
	vim.o.background = variant -- or "light" for light mode

	-- Load and setup function to choose plugin and language highlights
	lush(require("apprentice").setup({
		plugins = {
			"buftabline",
			"coc",
			"cmp", -- nvim-cmp
			"fzf",
			"gitgutter",
			"gitsigns",
			"lsp",
			"lspsaga",
			"nerdtree",
			"netrw",
			"nvimtree",
			"neogit",
			"packer",
			"signify",
			"startify",
			"syntastic",
			"telescope",
			"treesitter",
		},
		langs = {
			"c",
			"clojure",
			"coffeescript",
			"csharp",
			"css",
			"elixir",
			"golang",
			"haskell",
			"html",
			"java",
			"js",
			"json",
			"jsx",
			"lua",
			"markdown",
			"moonscript",
			"objc",
			"ocaml",
			"purescript",
			"python",
			"ruby",
			"rust",
			"scala",
			"typescript",
			"viml",
			"xml",
		},
	}))
end

return M
