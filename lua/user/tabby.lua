-- Tabby
-- https://github.com/UserEast/nightfox.nvim/tree/main/mics/tabby.lua
--
-- This file is a complete example of creating the tabby configuration shown in the readme of
-- nightfox. This configuration generates its own highlight groups from the currently applied
-- colorscheme. These highlight groups are regenreated on colorscheme changes.
--
-- Required plugins:
--    - `nanozuki/tabby.nvim`
--
-- This file is required to be in your `lua` folder of your config.  Your colorscheme should also
-- be applied before this file is sourced. This file cannot be located `lua/tabby.lua` as this
-- would clash with the actual plugin require path.
--
--
-- # Example:
--
-- ```lua
-- vim.cmd("colorscheme nightfox")
-- require('user.ui.tabby')
-- ```
--
-- This assumes that this file is located at `lua/user/ui/tabby.lua`

local get_highlight = require("user.functions").get_highlight

----------------------------------------------------------------------------------------------------
-- Colors

---Set highlight group from provided table
---@param groups table
local function set_highlights(groups)
	for group, opts in pairs(groups) do
		vim.api.nvim_set_hl(0, group, opts)
	end
end

---Generate a color palette from the current applied colorscheme
---@return table
local function generate_pallet_from_colorscheme()
  -- stylua: ignore
  local color_map = {
    black     = { index = 0, default = "#393b44" },
    red       = { index = 1, default = "#c94f6d" },
    green     = { index = 2, default = "#81b29a" },
    yellow    = { index = 3, default = "#dbc074" },
    blue      = { index = 4, default = "#719cd6" },
    magenta   = { index = 5, default = "#9d79d6" },
    cyan      = { index = 6, default = "#63cdcf" },
    white     = { index = 7, default = "#dfdfe0" },
    b_black   = { index = 8, default = "#ffffff" },
    b_red     = { index = 9, default = "#c94f6d" },
    b_green   = { index = 10, default = "#81b29a" },
    b_yellow  = { index = 11, default = "#dbc074" },
    b_blue    = { index = 12, default = "#719cd6" },
    b_magenta = { index = 13, default = "#9d79d6" },
    b_cyan    = { index = 14, default = "#63cdcf" },
    b_white   = { index = 15, default = "#dfdfe0" },
  }

	local pallet = {}
	for name, value in pairs(color_map) do
		local global_name = "terminal_color_" .. value.index
		pallet[name] = vim.g[global_name] and vim.g[global_name] or value.default
	end

	pallet.sl = get_highlight("TabLineFill")
	pallet.tab = get_highlight("TabLine")
	pallet.sel = get_highlight("TabLineSel")
	pallet.fill = get_highlight("TabLineFill")

	return pallet
end

---Generate user highlight groups based on the current applied colorscheme
---
---NOTE: This is a global because I dont known where this file will be in your config
---and it is needed for the autocmd below
_G._generate_user_tabline_highlights = function()
	local pal = generate_pallet_from_colorscheme()

  -- stylua: ignore
  local sl_colors = {
    Black    = { fg = pal.black, bg = pal.sl.bg },
    Red      = { fg = pal.red, bg = pal.sl.bg },
    Green    = { fg = pal.green, bg = pal.sl.bg },
    Yellow   = { fg = pal.yellow, bg = pal.sl.bg },
    Blue     = { fg = pal.blue, bg = pal.sl.bg },
    Magenta  = { fg = pal.magenta, bg = pal.sl.bg },
    Cyan     = { fg = pal.cyan, bg = pal.sl.bg },
    White    = { fg = pal.white, bg = pal.sl.bg },
    BBlack   = { fg = pal.b_black, bg = pal.sl.bg },
    BRed     = { fg = pal.b_red, bg = pal.sl.bg },
    BGreen   = { fg = pal.b_green, bg = pal.sl.bg },
    BYellow  = { fg = pal.b_yellow, bg = pal.sl.bg },
    BBlue    = { fg = pal.b_blue, bg = pal.sl.bg },
    BMagenta = { fg = pal.b_magenta, bg = pal.sl.bg },
    BCyan    = { fg = pal.b_cyan, bg = pal.sl.bg },
    BWhite   = { fg = pal.b_white, bg = pal.sl.bg },
  }

	local colors = {}
	for name, value in pairs(sl_colors) do
		colors["User" .. name] = { fg = value.bg, bg = value.fg, bold = true }
		colors["UserRv" .. name] = { fg = value.fg, bg = value.bg, bold = true }
	end

	local groups = {
		-- tabline
		UserTLFill = { fg = pal.sl.fg, bg = pal.sl.bg },

		UserTLHead = { fg = pal.red, bg = pal.sl.bg, bold = true, italic = true },
		UserTLHeadSep = { fg = pal.red, bg = pal.sl.bg },
		UserTLHeadSepTail = { fg = pal.red, bg = pal.sl.bg },

		UserTLActive = { fg = pal.b_magenta, bg = pal.sl.bg, bold = true },
		UserTLActiveSep = { fg = pal.b_magenta, bg = pal.sl.bg },
		UserTLActiveSepTail = { fg = pal.b_magenta, bg = pal.sl.bg },

		UserTLInactive = { fg = pal.sl.fg, bg = pal.sl.bg, bold = true },
		UserTLInactiveSep = { fg = pal.b_magenta, bg = pal.sl.bg },
		UserTLInactiveSepTail = { fg = pal.b_magenta, bg = pal.sl.bg },

		UserTLActiveWin = { fg = pal.b_green, bg = pal.sl.bg, bold = true },
		UserTLActiveWinSep = { fg = pal.b_green, bg = pal.sl.bg },
		UserTLActiveWinSepTail = { fg = pal.b_green, bg = pal.sl.bg },

		UserTLInactiveWin = { fg = pal.b_green, bg = pal.sl.bg },
		UserTLInactiveWinSep = { fg = pal.b_green, bg = pal.sl.bg },
		UserTLInactiveWinSepTail = { fg = pal.b_green, bg = pal.sl.bg },
	}

	set_highlights(vim.tbl_extend("force", colors, groups))
end

_generate_user_tabline_highlights()

vim.api.nvim_create_augroup("UserTablineHighlightGroups", { clear = true })
vim.api.nvim_create_autocmd({ "SessionLoadPost", "ColorScheme" }, {
	callback = function()
		_generate_user_tabline_highlights()
	end,
})

----------------------------------------------------------------------------------------------------
-- Icons
local icons = require("user.icons").ui

local thin_left = icons.LeftThinCircle
local thin_right = icons.RightThinCircle
-- local thick_left = icons.LeftThickCircle
-- local thick_right = icons.RightThickCircle

local head_icons = {
	active = { left_sep = "", right_sep = thin_right },
	inactive = { left_sep = "", right_sep = thin_right },
	line_end = { left_sep = "", right_sep = thin_right },
}

local tail_icons = {
	active = { left_sep = thin_left, right_sep = thin_right },
	inactive = { left_sep = "", right_sep = thin_right },
	line_end = { left_sep = thin_left, right_sep = "" },
}

----------------------------------------------------------------------------------------------------
-- Tabby

local ok_filename, filename = pcall(require, "tabby.module.filename")
if not ok_filename then
	return
end
local ok_api, tab_api = pcall(require, "tabby.module.api")
if not ok_api then
	return
end
local ok_tabname, tab_name = pcall(require, "tabby.feature.tab_name")
if not ok_tabname then
	return
end

local cwd = function()
	return "   " .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t"):upper() .. " "
end

local line = {
	hl = "UserTLFill",
	layout = "tab_only",
	head = {
		{ cwd, hl = "UserTLHead" },
		{ head_icons.line_end.right_sep, hl = "UserTLHeadSepTail" },
	},
	active_tab = {
		label = function(tabid)
			local editted = tabid
			if vim.api.nvim_buf_get_option(0, "modified") then
				editted = icons.Pencil
			else
				editted = icons.Check
			end

			local icon = tab_name.get_raw(tabid)
			return {
				" " .. editted .. " " .. icon .. " ",
				hl = "UserTLActive",
			}
		end,
		left_sep = { head_icons.active.left_sep, hl = "UserTLActiveSep" },
		right_sep = { head_icons.active.right_sep, hl = "UserTLActiveSepTail" },
	},
	inactive_tab = {
		label = function(tabid)
			local editted = tabid
			if
				vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(vim.api.nvim_tabpage_get_win(tabid)), "modified")
			then
				editted = icons.Pencil
			else
				editted = tabid
			end

			local icon = tab_name.get_raw(tabid)
			return {
				" " .. editted .. " " .. icon .. " ",
				hl = "UserTLInactive",
			}
		end,
		left_sep = { head_icons.inactive.left_sep, hl = "UserTLInactiveSep" },
		right_sep = { head_icons.inactive.right_sep, hl = "UserTLInactiveSepTail" },
	},
	top_win = {
		label = function(winid)
			return {
				" " .. tab_api.get_win_tab(winid) .. "   " .. filename.unique(winid) .. " ",
				hl = "UserTLActiveWin",
			}
		end,
		left_sep = { tail_icons.active.left_sep, hl = "UserTLActiveWinSep" },
		right_sep = { tail_icons.active.right_sep, hl = "UserTLActiveWinSepTail" },
	},
	win = {
		label = function(winid)
			return {
				" " .. tab_api.get_win_tab(winid) .. "   " .. filename.unique(winid) .. " ",
				hl = "UserTLInactiveWin",
			}
		end,
		left_sep = { tail_icons.inactive.left_sep, hl = "UserTLInactiveWinSep" },
		right_sep = { tail_icons.inactive.right_sep, hl = "UserTLInactiveWinSepTail" },
	},
	tail = {
		{ tail_icons.line_end.left_sep, hl = "UserTLHeadSep" },
		{ "   ", hl = "UserTLHead" },
	},
}

local tabby_ok, tabby = pcall(require, "tabby")
if not tabby_ok then
	return
end

tabby.setup({
	tabline = line,
})
