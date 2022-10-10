local current_theme = require("user.themes.current_theme")

local colorscheme = current_theme.main
local sub_theme = current_theme.variant

local theme = require("user.themes")

theme.setup(colorscheme, sub_theme)
