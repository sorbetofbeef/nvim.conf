local ok, rose_pine = pcall(require, "rose-pine")
if not ok then
	return
end

local M = {}

M.setup = function(variant)
	local variants = {
		dawn = "dawn",
		moon = "moon",
		main = "main",
	}

	if variant == variants.dawn then
		vim.o.background = "light"
	end
	if variant == variants.moon then
		vim.o.background = "dark"
		vim.g.me_rose_pine_variant = variants.moon
	end

	if variant == variants.main then
		vim.o.background = "dark"
		vim.g.me_rose_pine_variant = variants.main
	end

	rose_pine.setup({
		--- @usage 'main' | 'moon'
		dark_variant = vim.g.me_rose_pine_variant,
		bold_vert_split = true,
		dim_nc_background = true,
		disable_background = false,
		disable_float_background = false,
		disable_italics = false,

		--- @usage string hex value or named color from rosepinetheme.com/palette
		groups = {
			background = "base",
			panel = "surface",
			border = "highlight_med",
			comment = "muted",
			link = "iris",
			punctuation = "subtle",

			error = "love",
			hint = "iris",
			info = "foam",
			warn = "gold",

			headings = {
				h1 = "iris",
				h2 = "foam",
				h3 = "rose",
				h4 = "gold",
				h5 = "pine",
				h6 = "foam",
			},
		},
	})

	-- set colorscheme after options
	vim.cmd("colorscheme rose-pine")
end

return M
