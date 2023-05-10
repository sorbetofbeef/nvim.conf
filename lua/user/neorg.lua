local neorg_status_ok, neorg = pcall(require, "neorg")
if not neorg_status_ok then
	return
end

neorg.setup({
	load = {
		["core.defaults"] = {},
		["core.dirman"] = {
			config = {
				workspaces = {
					hacking = "~/docs/hacking",
					rust = "~/docs/rust",
					flutter = "~/docs/flutter_dart",
					bartending = "~/Documents/bartending",
				},
				index = "index.norg",
			},
		},
		["core.concealer"] = {},
		["core.completion"] = {
			config = {
				engine = "nvim-cmp",
			},
		},
		["core.integrations.nvim-cmp"] = {},
		["core.qol.toc"] = {},
		["core.export.markdown"] = {},
	},
})
