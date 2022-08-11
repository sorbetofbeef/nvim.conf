local themeName = "dayfox"
require("user.themes").setup(themeName)
-- setup must be called before loading

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. themeName)
if not status_ok then
  return
end

