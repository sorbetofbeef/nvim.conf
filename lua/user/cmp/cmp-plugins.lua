local plugins_status_ok, plugins = pcall(require, 'cmp-plugins')
if not plugins_status_ok then
  return
end

plugins.setup({
  files = { "/User/me/.config/nvim/lua/user/plugins.lua" }
})
