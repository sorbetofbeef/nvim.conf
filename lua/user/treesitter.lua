local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	return
end

configs.setup({
	ensure_installed = "all", -- one of "all" or a list of languages
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

require('ts_context_commentstring.internal').update_commentstring({
  key = '__multiline',
})
