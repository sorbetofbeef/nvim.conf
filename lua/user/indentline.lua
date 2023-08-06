local status_ok, indent_blankline = pcall(require, "indent_blankline")
if not status_ok then
	return
end

indent_blankline.setup({
	show_current_context = true,
	show_current_context_start = true,
	char = "",
	context_char = "│",
	context_char_blankline = "╎",
	-- space_char_highlight_list = { "Error", "Function", "Class", "Keyword", "Array" },
	show_trailing_blankline_indent = false,
	show_first_indent_level = true,
	use_treesitter = true,
	use_treesitter_scope = true,
	buftype_exclude = { "terminal", "nofile" },
	filetype_exclude = {
		"sagafinder",
		"help",
		"packer",
		"lazy",
		"NvimTree",
		"neo-tree",
	},
})
