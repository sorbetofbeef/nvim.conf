local theme = os.getenv("DARK_THEME")
local variant = os.getenv("DARK_VARIANT")
local path = os.getenv("THEME_GITHUB_PATH")
local name = nil
local dependencies = nil

if theme == "embark" then
	name = "embark"
end

if theme == "catppuccin" then
	name = "embark"
end

if theme == "rose-pine" then
	name = "embark"
end

if theme == "apprentice" or "arctic" or "zenbones" or "mellifluous" then
	dependencies = "rktjmp/lush.nvim"
end

return {
	path,
	name = name and name or nil,
	dependencies = dependencies and dependencies or nil,
	config = function()
		require("user.themes." .. theme).setup(variant)
	end,
	lazy = true,
	priority = 1000,
}
