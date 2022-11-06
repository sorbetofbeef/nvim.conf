local okay, p = pcall(require, "poimandres")
if not okay then
	return
end

local M = {}

M.setup = function(_)
	p.setup({
		bold_vert_split = true, -- use bold vertical separators
		dim_nc_background = true, -- dim 'non-current' window backgrounds
	})
	vim.cmd("colorscheme poimandres")
end

return M
