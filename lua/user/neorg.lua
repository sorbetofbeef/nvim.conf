local neorg_status_ok, neorg = pcall(require, "neorg")
if not neorg_status_ok then
	return
end

neorg.setup({
	load = {
		["core.defaults"] = {},
		["core.norg.dirman"] = {
			config = {
				workspaces = {
					hacking = "~/Documents/hacking",
					rust = "~/Documents/rust",
					flutter = "~/Documents/flutter_dart",
					bartending = "~/Documents/bartending",
				},
				index = "index.norg",
			},
		},
		["core.norg.concealer"] = {},
		["core.norg.completion"] = {
			config = {
				engine = "nvim-cmp",
			},
		},
		["core.integrations.nvim-cmp"] = {},
		["core.norg.qol.toc"] = {},
		["core.export.markdown"] = {},
	},
})
