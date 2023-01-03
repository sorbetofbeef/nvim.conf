local tabby_name = require("tabby.feature.tab_name")
local winid = require("tabby.module.api").get_tab_current_win
local file_name = require("tabby.module.filename").tail
local name_icon = require("user.functions").change_statusbar_name
local change_ft = require("user.functions")

vim.api.nvim_create_augroup("StatusBarRename", { clear = true })
vim.api.nvim_create_autocmd({ "TabEnter", "TabNew", "BufRead", "BufWinEnter", "BufNew" }, {
	group = "StatusBarRename",
	callback = function()
		local winbar_filetype = {}
		for tab, ni in pairs(name_icon()) do
			tabby_name.set(tab, ni.icon .. " " .. file_name(winid(tab)))
			table.insert(winbar_filetype, tab, ni.name)
		end
		vim.g.filetype_name = change_ft
	end,
})
