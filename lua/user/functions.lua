local M = {}

vim.cmd([[
  function Test()
    %SnipRun
    call feedkeys("\<esc>`.")
  endfunction
  function TestI()
    let b:caret = winsaveview()    
    %SnipRun
    call winrestview(b:caret)
  endfunction
]])

function M.sniprun_enable()
	vim.cmd([[
    %SnipRun
    augroup _sniprun
     autocmd!
     autocmd TextChanged * call Test()
     autocmd TextChangedI * call TestI()
    augroup end
  ]])
	vim.notify("Enabled SnipRun")
end

function M.disable_sniprun()
	M.remove_augroup("_sniprun")
	vim.cmd([[
    SnipClose
    SnipTerminate
    ]])
	vim.notify("Disabled SnipRun")
end

function M.toggle_sniprun()
	if vim.fn.exists("#_sniprun#TextChanged") == 0 then
		M.sniprun_enable()
	else
		M.disable_sniprun()
	end
end

function M.remove_augroup(name)
	if vim.fn.exists("#" .. name) == 1 then
		vim.cmd("au! " .. name)
	end
end

vim.cmd([[ command! SnipRunToggle execute 'lua require("user.functions").toggle_sniprun()' ]])

-- get length of current word
function M.get_word_length()
	local word = vim.fn.expand("<cword>")
	return #word
end

function M.toggle_option(option)
	local value = not vim.api.nvim_get_option_value(option, {})
	vim.opt[option] = value
	vim.notify(option .. " set to " .. tostring(value))
end

function M.toggle_tabline()
	local value = vim.api.nvim_get_option_value("showtabline", {})

	if value == 2 then
		value = 0
	else
		value = 2
	end

	vim.opt.showtabline = value

	vim.notify("showtabline" .. " set to " .. tostring(value))
end

local diagnostics_active = true
function M.toggle_diagnostics()
	diagnostics_active = not diagnostics_active
	if diagnostics_active then
		vim.diagnostic.show()
	else
		vim.diagnostic.hide()
	end
end

function M.isempty(s)
	return s == nil or s == ""
end

function M.get_buf_option(opt)
	local status_ok, buf_option = pcall(vim.api.nvim_buf_get_option, 0, opt)
	if not status_ok then
		return nil
	else
		return buf_option
	end
end

function M.smart_quit()
	local bufnr = vim.api.nvim_get_current_buf()
	local modified = vim.api.nvim_buf_get_option(bufnr, "modified")
	if modified then
		vim.ui.input({
			prompt = "You have unsaved changes. Quit anyway? (y/n) ",
		}, function(input)
			if input == "y" then
				vim.cmd("q!")
			end
		end)
	else
		vim.cmd("q!")
	end
end

M.vi_hl = {
	vi = {
		-- Map vi mode to text name
		text = {
			n = " ",
			no = " ",
			i = " ",
			v = "﫦",
			V = " ",
			[""] = " ",
			c = " ",
			cv = " ",
			ce = " ",
			R = " ",
			Rv = " ",
			s = " ",
			S = " ",
			[""] = " ",
			t = " ",
		},

		-- Maps vi mode to highlight group color defined above
		colors = {
			n = "UserBlue",
			no = "UserBlue",
			i = "UserSLStatus",
			v = "UserMagenta",
			V = "UserMagenta",
			[""] = "UserMagenta",
			R = "UserRed",
			Rv = "UserRed",
			r = "UserCyan",
			rm = "UserCyan",
			s = "UserMagenta",
			S = "UserMagenta",
			[""] = "UserMagenta",
			c = "UserYellow",
			["!"] = "UserCyan",
			t = "UserCyan",
		},

		-- Maps vi mode to separator highlight group defined above
		sep = {
			n = "UserSepBlue",
			no = "UserSepBlue",
			i = "UserSepWhite",
			v = "UserSepMagenta",
			V = "UserSepMagenta",
			[""] = "UserSepMagenta",
			R = "UserSepRed",
			Rv = "UserSepRed",
			r = "UserSepCyan",
			rm = "UserSepCyan",
			s = "UserSepMagenta",
			S = "UserSepMagenta",
			[""] = "UserSepMagenta",
			c = "UserSepYellow",
			["!"] = "UserSepCyan",
			t = "UserSepCyan",
		},
	},
}

-- Get highlight group from vi mode
---@return string
function M.vi_hl:mode(m)
	return self.vi.colors[m()] or "UserSLViBlack"
end

---@return string
function M.vi_hl:sep(m)
	return self.vi.sep[m()] or "UserSLBlack"
end

---@return string
function M.vi_hl:txt(m)
	return self.vi.text[m()] or " ?? "
end

local labels = {
	lua = { name = "LUA", icon = " " },
	sh = { name = "SHELL", icon = " " },
	bash = { name = "BASH SHELL", icon = " " },
	zsh = { name = "Z-SHELL", icon = " " },
	fish = { name = "FISH SHELL", icon = " " },
	python = { name = "PYTHON", icon = " " },
	json = { name = "JSON", icon = " " },
	html = { name = "HTML", icon = " " },
	css = { name = "CSS", icon = " " },
	go = { name = "GO", icon = " " },
	gohtml = { name = "GO HTML TEMPLATE", icon = " " },
	gotmpl = { name = "GO TEMPLATE", icon = " " },
	rust = { name = "RUST", icon = " " },
	dart = { name = "FlUTTER/DART", icon = " " },
	toml = { name = "TOML", icon = " " },
	yaml = { name = "YAML", icon = " " },
	javascript = { name = "JAVASCRIPT", icon = " " },
	typescript = { name = "TYPESCRIPT", icon = " " },
	javascriptreact = { name = "REACT(JS)", icon = " " },
	typescriptreact = { name = "REACT(TS)", icon = " " },
	markdown = { name = "MARKDOWN", icon = " " },
	vim = { name = "VIMSCRIPT", icon = " " },
	ini = { name = "CONFIG", icon = " " },
	conf = { name = "CONFIG", icon = " " },
	text = { name = "TEXT", icon = " " },
	svg = { name = "SVG", icon = " " },
	dbui = { name = "", icon = " " },
}

M.change_statusbar_name = function()
	local name_icon = {}
	for _, tab in ipairs(vim.api.nvim_list_tabpages()) do
		for type, name_icons in pairs(labels) do
			local win_id = vim.api.nvim_tabpage_get_win(tab)
			if vim.api.nvim_buf_get_option(0, "filetype") ~= "neo-tree" or "Outline" then
				if vim.filetype.match({ buf = vim.api.nvim_win_get_buf(win_id) }) == type then
					name_icon[tab] = { name = name_icons.name, icon = name_icons.icon }
				end
			end
		end
	end

	return name_icon
end

local get_wins = function()
	local tab = {}
	for _, wins in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
		table.insert(tab, wins)
	end
	return tab
end

M.get_win_icons = function()
	local win_icons = {}
	local wins = get_wins()
	for _, win in ipairs(wins) do
		for type, name_icons in pairs(labels) do
			if vim.api.nvim_buf_get_option(0, "filetype") ~= "neo-tree" or "Outline" then
				if vim.filetype.match({ buf = vim.api.nvim_win_get_buf(win) }) == type then
					win_icons[win] = name_icons.name
				end
			end
		end
	end

	return win_icons
end

local fmt = string.format
---Convert color number to hex string
---@param n number
---@return string
local hex = function(n)
	if n then
		return fmt("#%06x", n)
	end
	return ""
	---@diagnostic disable-next-line: missing-return
end

---Parse `style` string into nvim_set_hl options
---@param style string
---@return table
local function parse_style(style)
	if not style or style == "NONE" then
		return {}
	end

	local result = {}
	for token in string.gmatch(style, "([^,]+)") do
		result[token] = true
	end

	return result
end

---Get highlight opts for a given highlight group name
---@param name string
---@return table
M.get_highlight = function(name)
	local hl = vim.api.nvim_get_hl_by_name(name, true)
	if hl.link then
		return M.get_highlight(hl.link)
	end

	local result = parse_style(hl.style)
	result.fg = hl.foreground and hex(hl.foreground)
	result.bg = hl.background and hex(hl.background)
	result.sp = hl.special and hex(hl.special)

	return result
end

return M
