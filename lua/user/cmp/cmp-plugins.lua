local plugins_status_ok, plugins = pcall(require, "cmp-plugins")
if not plugins_status_ok then
	return
end

plugins.setup({
	files = {
		"/Users/me/.local/share/nvim/site/pack/packer/opt/.*",
		"/Users/me/.local/share/nvim/site/pack/packer/start/.*",
		"/Users/me/.config/nvim/lua/user/plugins.lua",
	},
})
