local M = {}

M.setup = function(theme_name, variant)
	local themes = {
		"nightfox",
    "catppuccin",
		"kanagawa",
		"material",
		"rasmus",
		"starry",
		"tokyonight",
    "aquarium",
    "onedarkpro",
    "melange",
    "mellow",
    "tokyonight",
    "ayu",
    "apprentice",
    "poimandres",
    "doom_one",
	}

	for _, theme in ipairs(themes) do
		if theme == theme_name then
			require("user.themes." .. theme_name).setup(variant)
			break
		end
	end
end

return M
