local M = {}

M.setup = function(variant)
	vim.opt.laststatus = 3

	vim.opt.fillchars:append({
		horiz = "═",
		horizup = "╩",
		horizdown = "╦",
		vert = "║",
		vertleft = "╣",
		vertright = "╠",
		verthoriz = "╬",
	})
	vim.opt.background = ""

	require("kanagawa").setup({
		undercurl = true, -- enable undercurls
		commentStyle = { italic = true },
		functionStyle = { italic = true, bold = true },
		keywordStyle = { bold = true },
		statementStyle = {},
		typeStyle = { bold = true },
		variablebuiltinStyle = { bold = true },
		specialReturn = true, -- special highlight for the return keyword
		specialException = true, -- special highlight for exception handling keywords
		transparent = false, -- do not set background color
		dimInactive = true, -- dim inactive window `:h hl-NormalNC`
		globalStatus = true, -- adjust window separators highlight for laststatus=3
		colors = {
			theme = {
				all = {
					ui = {
						bg_gutter = "none",
					},
				},
			},
		},
		theme = variant,
		overrides = function(colors)
			local theme = colors.theme
			return {
				NormalFloat = { bg = "none" },
				FloatBorder = { bg = "none" },
				FloatTitle = { bg = "none" },

				-- Save an hlgroup with dark background and dimmed foreground
				-- so that you can use it where your still want darker windows.
				-- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
				NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

				-- Popular plugins that open floats will link to NormalFloat by default;
				-- set their background accordingly if you wish to keep them dark and borderless
				LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
				TelescopeTitle = { fg = theme.ui.special, bold = true },
				TelescopePromptNormal = { bg = theme.ui.bg_p1 },
				TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
				TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
				TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
				TelescopePreviewNormal = { bg = theme.ui.bg_dim },
				TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },
				Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 }, -- add `blend = vim.o.pumblend` to enable transparency
				PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
				PmenuSbar = { bg = theme.ui.bg_m1 },
				PmenuThumb = { bg = theme.ui.bg_p2 },
				MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
			}
		end,
	})

	vim.cmd("colorscheme kanagawa")
end

return M
