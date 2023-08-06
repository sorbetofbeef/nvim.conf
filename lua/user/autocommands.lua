-- Dyanamicly generates augroups
local function augroup(name)
	return vim.api.nvim_create_augroup("user_group_" .. name, { clear = true })
end

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
	group = augroup("checktime"),
	command = "checktime",
})

-- Use 'q' to quit from common plugins
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "qf", "help", "man", "Outline", "/^dap-.*/", "Trouble", "lspinfo", "spectre_panel", "lir" },
	callback = function()
		vim.cmd([[
      nnoremap <silent> <buffer> q :close<CR> 
      set nobuflisted 
    ]])
	end,
})

-- Set wrap and spell in markdown and gitcommit
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "gitcommit", "markdown" },
	callback = function()
		vim.opt_local.wrap = true
	end,
})

--[[ vim.cmd(
	"autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'neo-tree filesystem [' .. tabpagenr() .. ']' | quit | endif"
) ]]

-- Fixes Autocomment
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
	callback = function()
		vim.cmd("set formatoptions-=cro")
	end,
})

-- Highlight Yanked Text
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
	group = augroup("highlight_yank"),
	callback = function()
		vim.highlight.on_yank({ higroup = "Visual", timeout = 600 })
	end,
})

vim.api.nvim_create_autocmd({ "VimResized" }, {
	group = augroup("resize_splits"),
	callback = function()
		vim.cmd("tabdo wincmd =")
	end,
})

-- Go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
	group = augroup("last_loc"),
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local lcount = vim.api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

vim.api.nvim_create_autocmd({ "CursorHold" }, {
	callback = function()
		local status_ok, luasnip = pcall(require, "luasnip")
		if not status_ok then
			return
		end
		if luasnip.expand_or_jumpable() then
			vim.cmd([[silent! lua require("luasnip").unlink_current()]])
		end
	end,
})

vim.api.nvim_create_autocmd({ "ColorScheme", "FileType" }, {
	pattern = "*",
	callback = function()
		vim.cmd([[
      hi IndentBlanklineChar gui=nocombine guifg=#444C55 guibg=NONE
      hi IndentBlanklineSpaceChar gui=nocombine guifg=#444C55 guibg=NONE
      hi IndentBlanklineContextChar gui=nocombine guifg=#FB5E2A guibg=NONE
      " NOTE: don't use `gui=nocombine` here to have correct coloring of gitsigns.nvim.
      hi IndentBlanklineContextStart gui=underline guisp=#FB5E2A
    ]])
	end,
})
