local okay, onedark = pcall(require, "onedark")
if not okay then
	return
end

local M = {}
M.setup = function(variant)
	onedark.setup({
		style = variant,
		cmp_itemkind_reverse = true,

		code_style = {
			keywords = "bold",
			comments = "italic",
			functions = "italic,bold",
			strings = "italic",
			variables = "none",
		},
	})

	require("onedark").load()
end

return M
