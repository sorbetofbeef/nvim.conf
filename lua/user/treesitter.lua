local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	return
end

configs.setup({
	ensure_installed = {
		"css",
		"html",
		"rust",
		"go",
		"javascript",
		"typescript",
		"graphql",
		"sql",
		"ruby",
		"json",
		"jsonc",
		"gomod",
		"svelte",
		"lua",
		"dockerfile",
		"devicetree",
		"comment",
		"cpp",
		"commonlisp",
		"embedded_template",
		"org",
		"meson",
		"gitignore",
		"nix",
		"ninja",
		"yaml",
		"c",
		"markdown_inline",
		"dart",
		"toml",
		"python",
		"tsx",
		"todotxt",
		"proto",
		"jq",
		"awk",
		"make",
		"git_rebase",
		"gitcommit",
		"gitattributes",
		"sxhkdrc",
		"json5",
		"vim",
		"terraform",
		"regex",
		"jsonnet",
		"markdown",
		"llvm",
		"scss",
		"help",
		"hjson",
		"norg",
		"jsdoc",
		"fennel",
		"http",
		"fish",
		"zig",
		"bash",
		"gowork",
		"diff",
		"cmake",
		"query",
	}, -- one of "all" or a list of languages
	ignore_install = { "php", "phpdoc" }, -- List of parsers to ignore installing
	highlight = {
		enable = true, -- false will disable the whole extension
		disable = { "markdown" }, -- list of language that will be disabled
	},
	autopairs = {
		enable = true,
	},
	indent = { enable = true, disable = { "python", "css", "rust" } },
	autotag = {
		enable = true,
		disable = { "xml", "markdown" },
	},
	context_commentstring = {
		enable = true,
		enable_autocmd = false,
		config = {
			dart = { __default = "// %s", __multiline = "/* %s */" },
		},
	},
})

require("ts_context_commentstring.internal").update_commentstring({
	key = "__multiline",
})
