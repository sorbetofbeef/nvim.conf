local okay, onedarkpro = pcall(require, "onedarkpro")
if not okay then
	return
end

local M = {}
M.setup = function(variant)

	onedarkpro.setup({
		options = {
			bold = true,
			italic = true,
			underline = true,
			undercurl = true,
			cursorline = true,
			terminal_colors = true,
			window_unfocused_color = true,
		},
	})

  vim.o.background = variant
  vim.cmd("colorscheme onedarkpro")
end

return M
