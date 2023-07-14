local dependencies
if
	os.getenv("DARK_THEME") == "apprentice"
	or os.getenv("DARK_THEME") == "arctic"
	or os.getenv("DARK_THEME") == "zenbones"
	or os.getenv("DARK_THEME") == "mellifluous"
then
	dependencies = "rktjmp/lush.nvim"
end

local theme
if os.getenv("DARK_THEME") == "nightfox" then
	theme = os.getenv("DARK_VARIANT")
else
	theme = os.getenv("DARK_THEME")
end

local name = ""
if os.getenv("DARK_THEME") == "catppuccin" then
	name = "catppuccin"
end

if os.getenv("DARK_THEME") == "embark" then
	name = "embark"
end

local config_object = {
	os.getenv("THEME_GITHUB_PATH"),
	lazy = false,
	priority = 1000,
	config = function()
		require("user.themes." .. os.getenv("DARK_THEME")).setup(os.getenv("DARK_VARIANT"))
		vim.cmd("colorscheme " .. theme)
	end,
}

if name ~= "" then
	config_object.name = name
end

return config_object
