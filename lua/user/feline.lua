local fmt = string.format

local feline = require("feline")
local navic = require("nvim-navic")
local vi_hl = require("user.functions").vi_hl
local get_highlight = require("user.functions").get_highlight
-- local get_filetype_name = require("user.functions").change_statusbar_name

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
  local colors = {
    black   = { index = 0, default = "#393b44" },
    red     = { index = 1, default = "#c94f6d" },
    green   = { index = 2, default = "#81b29a" },
    yellow  = { index = 3, default = "#dbc074" },
    blue    = { index = 4, default = "#719cd6" },
    magenta = { index = 5, default = "#9d79d6" },
    cyan    = { index = 6, default = "#63cdcf" },
    white   = { index = 7, default = "#dfdfe0" },
  }
	local bright_colors = {
		b_black = { index = 8, default = colors.black.default },
		b_red = { index = 9, default = colors.red.default },
		b_green = { index = 10, default = colors.green.default },
		b_yellow = { index = 11, default = colors.yellow.default },
		b_blue = { index = 12, default = colors.blue.default },
		b_magenta = { index = 13, default = colors.magenta.default },
		b_cyan = { index = 14, default = colors.cyan.default },
		b_white = { index = 15, default = colors.white.default },
	}

	local diagnostic_map = {
		hint = { hl = "DiagnosticHint", default = colors.green.default },
		info = { hl = "DiagnosticInfo", default = colors.blue.default },
		warn = { hl = "DiagnosticWarn", default = colors.yellow.default },
		error = { hl = "DiagnosticError", default = colors.red.default },
	}

	local pallet = {}
	for name, value in pairs(colors) do
		local global_name = "terminal_color_" .. value.index
		pallet[name] = vim.g[global_name] and vim.g[global_name] or value.default
	end

	for name, value in pairs(bright_colors) do
		local global_name = "terminal_color_" .. value.index
		pallet[name] = vim.g[global_name] and vim.g[global_name] or value.default
	end

	for name, value in pairs(diagnostic_map) do
		pallet[name] = get_highlight(value.hl).fg or value.default
	end

	pallet.sl = get_highlight("TabLineFill")
	pallet.sel = get_highlight("TabLineSel")

	return pallet
end

---Generate user highlight groups based on the current applied colorscheme
---
---NOTE: This is a global because I dont known where this file will be in your config
---and it is needed for the autocmd below
_G._gen_user_statusline_highlights = function()
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
    BBlack   = { fg = pal.b_black, bg = pal.bg },
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
		colors["User" .. name] = { fg = value.fg, bg = value.bg, bold = true }
		colors["UserRv" .. name] = { fg = value.bg, bg = value.fg, bold = true }
		colors["UserSep" .. name] = { fg = value.fg, bg = value.bg, bold = true }
		colors["UserBG_" .. name] = { fg = value.fg, bg = pal.blue, bold = true }
	end

	local status = vim.o.background == "dark" and { fg = pal.white, bg = pal.black }
		or { fg = pal.white, bg = pal.black }

	local groups = {
		-- statusline
		StatusLine = { fg = pal.sl.fg, bg = pal.sl.bg },
		UserSLHint = { fg = pal.sl.bg, bg = pal.hint, bold = true },
		UserSLInfo = { fg = pal.sl.bg, bg = pal.info, bold = true },
		UserSLWarn = { fg = pal.sl.bg, bg = pal.warn, bold = true },
		UserSLError = { fg = pal.sl.bg, bg = pal.error, bold = true },
		UserSLStatus = { fg = status.fg, bg = status.bg, bold = true },

		UserPercent = { fg = pal.black, bg = pal.b_yellow, bold = true },
		UserPercentSep = { fg = pal.b_yellow, bg = pal.sl.bg, bold = true },
		UserPercentSepTail = { fg = pal.sl.bg, bg = pal.b_yellow, bold = true },

		UserPositionSep = { fg = pal.black, bg = pal.sl.bg, bold = true },

		UserSLFtHint = { fg = pal.sel.bg, bg = pal.info },
		UserSLHintInfo = { fg = pal.hint, bg = pal.sl.bg },
		UserSLInfoWarn = { fg = pal.info, bg = pal.hint },
		UserSLWarnError = { fg = pal.warn, bg = pal.info },
		UserSLErrorStatus = { fg = pal.error, bg = pal.warn },
		UserSLStatusBg = { fg = status.bg, bg = pal.error },

		UserSLAlt = { fg = pal.sl.fg, bg = pal.sl.bg, bold = true },
		UserSLAltSep = { fg = pal.sl.bg, bg = pal.sel.bg },
		UserSLGitBranch = { fg = pal.yellow, bg = pal.sl.bg },

		Name = { fg = pal.sl.bg, bg = pal.black, italic = true, bold = true },
		NameLeftSeparator = { fg = pal.green, bg = pal.green },
		NameRightSeparator = { fg = pal.green, bg = pal.sl.bg },

		Path = { fg = pal.b_yellow, bg = pal.sl.bg, bold = true },
		PathLeftSeparator = { fg = pal.yellow, bg = pal.sl.bg },
		PathRightSeparator = { fg = pal.yellow, bg = pal.sl.bg },

		Breadcrumbs = { fg = pal.b_cyan, bg = pal.sl.bg, bold = true },
		BreadcrumbsLeftSeparator = { fg = pal.b_cyan, bg = pal.sl.bg },
		BreadcrumbsRightSeparator = { fg = pal.b_cyan, bg = pal.sl.bg },
	}

	set_highlights(vim.tbl_extend("force", colors, groups))
end

_gen_user_statusline_highlights()

vim.api.nvim_create_augroup("UserStatuslineHighlightGroups", { clear = true })
vim.api.nvim_create_autocmd({ "SessionLoadPost", "ColorScheme" }, {
	callback = function()
		_gen_user_statusline_highlights()
	end,
})

----------------------------------------------------------------------------------------------------
-- Feline

local icons = {
	locker = " ", -- #f023
	page = "☰", -- 2630
	line_number = "", -- e0a1
	connected = " ", -- f817
	dos = " ", -- e70f
	unix = " ", -- f17c
	mac = " ", -- f179
	mathematical_L = "𝑳",
	vertical_bar = "┃",
	vertical_bar_thin = "│",
	left = "",
	right = "",
	block = "█",
	left_filled = "",
	right_filled = "",
	slant_left = "",
	slant_left_thin = "",
	slant_right = "",
	slant_right_thin = "",
	slant_left_2 = "",
	slant_left_2_thin = "",
	slant_right_2 = "",
	slant_right_2_thin = "",
	left_rounded = " ",
	left_rounded_thin = "",
	right_rounded = "",
	right_rounded_thin = "",
	circle = "●",
}

---Get the number of diagnostic messages for the provided severity
---@param str string [ERROR | WARN | INFO | HINT]
---@return string
local function get_diag(str)
	local diagnostics = vim.diagnostic.get(0, { severity = vim.diagnostic.severity[str] })
	local count = #diagnostics

	return (count > 0) and " " .. str .. ": " .. count .. " " or ""
end

---Get the path of the file relative to the cwd
---@return string
--[[ local function file_info()
  local list = {}
  if vim.bo.readonly then
    table.insert(list, "🔒")
  end

  if vim.bo.modified then
    table.insert(list, "●")
  end

  table.insert(list, vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":~:."))

  return table.concat(list, " ")
end ]]

-- Create a table that contains every status line commonent
local user_icons = require("user.icons")
local l_sep = user_icons.ui.LeftThickCircle
local r_sep = user_icons.ui.RightThickCircle
local l_alt_sep = user_icons.ui.LeftThinCircle
-- local r_alt_sep = user_icons.ui.RightThinCircle

local c = {
	command = {
		provider = function() end,
	},
	git_branch = {
		provider = "git_branch",
		icon = "   ",
		hl = "UserSLGitBranch",
		right_sep = { str = r_sep, hl = "UserSLGitBranch" },
	},
	fileinfo = {
		provider = { name = "file_info", opts = { type = "relative" } },
		hl = "UserSLAlt",
		left_sep = { str = r_sep, hl = "UserSLAltSep" },
		right_sep = { str = r_sep, hl = "UserSLAltSep" },
	},
	file_enc = {
		provider = function()
			local os = icons[vim.bo.fileformat] or ""
			return fmt(" %s %s ", os, vim.bo.fileencoding)
		end,
		hl = "UserBMagenta",
		left_sep = { str = l_alt_sep, hl = "UserBMagenta" },
	},
	cur_position = {
		provider = function()
			-- TODO: What about 4+ diget line numbers?
			return fmt(" %3d:%-2d ", unpack(vim.api.nvim_win_get_cursor(0)))
		end,
		hl = "UserYellow",
		left_sep = { str = l_alt_sep, hl = "UserYellow" },
	},
	cur_percent = {
		provider = function()
			return " " .. require("feline.providers.cursor").line_percentage() .. "  "
		end,
		hl = "UserPercent",
		left_sep = { str = l_sep, hl = "UserPercentSep" },
	},
	default = { -- needed to pass the parent StatusLine hl group to right hand side
		provider = "",
		hl = "StatusLine",
	},
	lsp_status = {
		provider = function()
			return vim.tbl_count(vim.lsp.get_active_clients()) == 0 and " "
				or " ◦ " .. vim.tbl_count(vim.lsp.get_active_clients()) .. " "
		end,
		hl = "UserSLStatus",
		right_sep = { str = r_sep, hl = "UserSLStatusBg", always_visible = true },
		-- right_sep = { str = l_sep, hl = "UserSLErrorStatus", always_visible = true },
	},
	lsp_error = {
		provider = function()
			return get_diag("ERROR")
		end,
		hl = "UserSLError",
		right_sep = { str = r_sep, hl = "UserSLErrorStatus", always_visible = true },
		-- right_sep = { str = l_sep, hl = "UserSLWarnError", always_visible = true },
	},
	lsp_warn = {
		provider = function()
			return get_diag("WARN")
		end,
		hl = "UserSLWarn",
		right_sep = { str = r_sep, hl = "UserSLWarnError", always_visible = true },
		-- right_sep = { str = l_sep, hl = "UserSLInfoWarn", always_visible = true },
	},
	lsp_info = {
		provider = function()
			return get_diag("INFO")
		end,
		hl = "UserSLInfo",
		right_sep = { str = r_sep, hl = "UserSLInfoWarn", always_visible = true },
		-- right_sep = { str = r_sep, hl = "UserSLWarnError", always_visible = true },
		-- right_sep = { str = r_sep, hl = "UserSLHintInfo", always_visible = true },
	},
	lsp_hint = {
		provider = function()
			return get_diag("HINT")
		end,
		hl = "UserSLHint",
		right_sep = { str = r_sep, hl = "UserSLHintInfo", always_visible = true },
	},

	in_fileinfo = {
		provider = "file_info",
		hl = "StatusLine",
	},
	in_position = {
		provider = "position",
		hl = "StatusLine",
	},
	--[[ file_winbar = {
    provider = "file_info",
    hl = "Comment",
  }, ]]
}

local active = {
	{ -- left
		-- c.vimode,
		c.lsp_status,
		c.lsp_error,
		c.lsp_warn,
		c.lsp_info,
		c.lsp_hint,
		c.gitbranch,
		-- c.command,
		c.default, -- must be last
	},
	{ -- right
		-- c.file_type,
		c.file_enc,
		c.cur_position,
		c.cur_percent,
	},
}

local inactive = {
	{ c.in_fileinfo }, -- left
	{ c.in_position }, -- right
}

require("feline").setup({
	components = { active = active, inactive = inactive },
	highlight_reset_triggers = {},
	force_inactive = {
		filetypes = {
			"NvimTree",
			"neo-tree",
			"packer",
			"dap-repl",
			"dapui_scopes",
			"dapui_stacks",
			"dapui_watches",
			"dapui_repl",
			"LspTrouble",
			"qf",
			"help",
			"Outline",
		},
		buftypes = { "terminal" },
		bufnames = {},
	},
	disable = {
		filetypes = {
			"dashboard",
			"startify",
			"alpha",
			"neo-tree",
		},
	},
})

local components = {
	active = { {}, {} },
}

local win_labels = require("user.functions").get_win_icons
local names = {}

vim.api.nvim_create_augroup("FelineStatus", { clear = true })
vim.api.nvim_create_autocmd({ "BufWinEnter", "WinEnter" }, {
	group = "FelineStatus",
	callback = function()
		for win, name in pairs(win_labels()) do
			names[win] = name
		end
	end,
})

vim.api.nvim_create_autocmd("WinClosed", {
	group = "FelineStatus",
	callback = function(file)
		names[file] = nil
	end,
})

table.insert(components.active[1], {
	provider = function()
		return fmt("%s %s ", names[vim.api.nvim_get_current_win()], vi_hl:txt(vim.fn.mode))
	end,
	hl = function()
		return vi_hl:mode(vim.fn.mode)
	end,
	right_sep = {
		str = user_icons.ui.RightThinCircle,
		hl = function()
			return vi_hl:sep(vim.fn.mode)
		end,
	},
})

--[[ table.insert(components.active[1], {
	provider = function()
		local full_path = vim.uri_from_bufnr(0)
		local filename = vim.uri_to_fname(full_path)
		local relative_name = " " .. vim.fn.fnamemodify(filename, ":~:.")
		return relative_name
	end,
	enabled = function()
		return navic.is_available()
	end,
	right_sep = { str = user_icons.ui.RightThinCircle, hl = "PathRightSeparator" },
	hl = "Path",
}) ]]

table.insert(components.active[1], {
	provider = function()
		return " " .. navic.get_location()
	end,
	enabled = function()
		return navic.is_available()
	end,
	hl = "Breadcrumbs",
	right_sep = { str = user_icons.ui.RightThinCircle, hl = "BreadcrumbsRightSeparator" },
})

feline.winbar.setup({
	force_inactive = {
		filetypes = {
			"^NvimTree$",
			"^neo-tree$",
			"^packer$",
			"^dap-repl$",
			"^dapui_scopes$",
			"^dapui_stacks$",
			"^dapui_watches$",
			"^dapui_repl$",
			"^LspTrouble$",
			"^qf$",
			"^help$",
			"^Outline$",
			"^help$",
			"^packer$",
		},
		buftypes = { "terminal" },
		bufnames = { "neo-tree filesystem [" .. vim.api.nvim_get_current_tabpage() .. "]" },
	},
	disable = {
		filetypes = {
			"^neo-tree$",
			"^neotree$",
			"^dashboard$",
			"^startify$",
			"^alpha$",
			"^qf$",
			"^Outline$",
			"^packer$",
			"^dap-repl$",
			"^dapui_scopes$",
			"^dapui_stacks$",
			"^dapui_watches$",
			"^dapui_repl$",
			"^LspTrouble$",
			"^netrw$",
			"^help$",
			"^packer$",
		},
		buftypes = { "^terminal$" },
		bufnames = {},
	},
	components = components,
})

return M
