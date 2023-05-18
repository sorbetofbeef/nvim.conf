local M = {}

M.setup = function(variant)
	local init = function()
		vim.g.aqua_bold = true
		vim.g.aquarium_style = variant

		vim.cmd("colorscheme aquarium")
	end
	return {
		"",
		config = function()
			init()
		end,
		lazy = true,
		priority = 1000,
	}
end
return M
