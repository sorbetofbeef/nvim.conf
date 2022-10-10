local M = {}

M.setup = function(themeName, subTheme)
	local themes = {
		"nightfox",
    "catppuccin",
		"kannagawa",
		"material",
		"rasmus",
		"starry",
		"tokyonight",
    "aquarium",
    "onedarkpro",
    "melange",
	}

	for _, theme in ipairs(themes) do
		if theme == themeName then
			require("user.themes." .. themeName).setup(subTheme)
			break
		end
	end
end

return M
