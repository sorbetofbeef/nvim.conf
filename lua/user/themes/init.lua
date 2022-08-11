local M = {}

M.setup = function (themeName)
  local themes = {
    "nightfox",
    "dayfox",
    "nordfox",
    "dawnfox",
    "duskfox",
    "terafox",
    "kannagawa",
    "material",
    "rasmus",
    "starry",
    "tokyonight",
  }
  for _, theme in ipairs(themes) do
    if theme == themeName then
      require("user.themes." .. themeName).setup()
    end
  end
end

return M

