local setup = function()
	local current_theme = require("user.themes.current_theme")
	require("user.themes." .. current_theme.main).setup(current_theme.variant)
end

setup()
