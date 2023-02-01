local ok, illuminate = pcall(require, "illuminate")
if not ok then
	return
end

illuminate.configure({
	filetype_denylist = {
		"Outline",
		"neo-tree",
		"Trouble",
		"cflist",
		"telescope",
		"loclist",
		"pum",
		"terminal",
		"loclist",
	},
	modes_denylist = {
		"i",
		"ix",
		"ic",
		"c",
		"cv",
		"v",
		"vs",
		"r",
		"rm",
		"r?",
		"R",
		"Rc",
		"Rx",
		"Rv",
		"Rvc",
		"Rvx",
		"nt",
		"t",
	},
	under_cursor = false,
})

vim.api.nvim_set_keymap("n", "g<c-n>", '<cmd>lua require"illuminate".next_reference{wrap=true}<cr>', { noremap = true })
vim.api.nvim_set_keymap(
	"n",
	"g<c-p>",
	'<cmd>lua require"illuminate".next_reference{reverse=true,wrap=true}<cr>',
	{ noremap = true }
)
