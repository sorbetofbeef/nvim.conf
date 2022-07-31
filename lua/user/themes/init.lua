require("user.themes.nightfox").setup()
-- setup must be called before loading
local colorscheme = "terafox"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  return
end

