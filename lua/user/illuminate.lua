vim.g.Illuminate_ftblacklist = { "alpha", "neo-tree", "Outline" }
vim.api.nvim_set_keymap("n", "g<c-n>", '<cmd>lua require"illuminate".next_reference{wrap=true}<cr>', { noremap = true })
vim.api.nvim_set_keymap(
	"n",
	"g<c-p>",
	'<cmd>lua require"illuminate".next_reference{reverse=true,wrap=true}<cr>',
	{ noremap = true }
)
