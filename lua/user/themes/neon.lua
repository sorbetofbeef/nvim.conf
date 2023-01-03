local ok, _ = pcall(require, "neon")
if ok ~= true then
	return
end

local M = {}

M.setup = function(variant)
	vim.g.neon_style = variant

	vim.g.neon_italic_function = true
	vim.g.neon_italic_keyword = true
	vim.g.neon_bold = true
	vim.g.neon_transparent = false

	vim.cmd([[colorscheme neon]])
end

return M
