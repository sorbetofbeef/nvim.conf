vim.g.neo_tree_remove_legacy_commands = 1

local left = require("user.icons").ui.LeftThinCircle
local right = require("user.icons").ui.RightThinCircle

-- If you want icons for diagnostic errors, you'll need to define them somewhere:
vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = " ", texthl = "DiagnosticSignHint" })
-- NOTE: this is changed from v1.x, which used the old style of highlight groups
-- in the form "LspDiagnosticsSignWarning"

require("neo-tree").setup({
	sources = {
		"filesystem",
		"buffers",
		"git_status",
	},
	source_selector = {
		winbar = true, -- toggle to show selector on winbar
		statusline = false, -- toggle to show selector on statusline
		show_scrolled_off_parent_node = true, -- this will replace the tabs with the parent path
		-- of the top visible node when scrolled down.
		tab_labels = { -- falls back to source_name if nil
			filesystem = " ",
			buffers = " ",
			git_status = " ",
			diagnostics = " ",
		},
		content_layout = "center", -- only with `tabs_layout` = "equal", "focus"
		--                start  : |/ 裡 bufname     \/...
		--                end    : |/     裡 bufname \/...
		--                center : |/   裡 bufname   \/...
		tabs_layout = "equal", -- start, end, center, equal, focus
		--             start  : |/  a  \/  b  \/  c  \            |
		--             end    : |            /  a  \/  b  \/  c  \|
		--             center : |      /  a  \/  b  \/  c  \      |
		--             equal  : |/    a    \/    b    \/    c    \|
		--             active : |/  focused tab    \/  b  \/  c  \|
		truncation_character = "…", -- character to use when truncating the tab label
		tabs_min_width = nil, -- nil | int: if int padding is added based on `content_layout`
		tabs_max_width = nil, -- this will truncate text even if `text_trunc_to_fit = false`
		padding = 0, -- can be int or table
		-- padding = { left = 2, right = 0 },
		-- separator = "▕", -- can be string or table, see below
		separator = { left = left, right = right, override = "right" },
		-- separator = { left = "/", right = "\\", override = nil },     -- |/  a  \/  b  \/  c  \...
		-- separator = { left = "/", right = "\\", override = "right" }, -- |/  a  \  b  \  c  \...
		-- separator = { left = "/", right = "\\", override = "left" },  -- |/  a  /  b  /  c  /...
		-- separator = { left = "/", right = "\\", override = "active" },-- |/  a  / b:active \  c  \...
		-- separator = "|",                                              -- ||  a  |  b  |  c  |...
		separator_active = nil, -- set separators around the active tab. nil falls back to `source_selector.separator`
		show_separator_on_edge = true,
		--                       true  : |/    a    \/    b    \/    c    \|
		--                       false : |     a    \/    b    \/    c     |
		highlight_tab = "NeoTreeTabSeparatorActive",
		highlight_tab_active = "NeoTreeTabActive",
		highlight_background = "NeoTreeTabActive",
		highlight_separator = "NeoTreeTabSeparatorActive",
		highlight_separator_active = "NeoTreeTabActive",
	},
	close_if_last_window = false, -- Close Neo-tree if it is the last window left in the tab
	popup_border_style = "rounded",
	enable_git_status = true,
	enable_diagnostics = true,
	open_files_in_last_window = false,
	sort_case_insensitive = false, -- used when sorting files and directories in the tree
	sort_function = nil, -- use a custom function for sorting files and directories in the tree
	-- sort_function = function (a,b)
	--       if a.type == b.type then
	--           return a.path > b.path
	--       else
	--           return a.type > b.type
	--       end
	--   end , -- this sorts files and directories descendantly
	event_handlers = {
		{
			event = "file_opened",
			handler = function(file_path)
				--auto close
				require("neo-tree").close_all()
			end,
		},
	},
	default_component_configs = {
		container = {
			enable_character_fade = true,
		},
		indent = {
			indent_size = 1,
			padding = 0, -- extra padding on left hand side
			-- indent guides
			with_markers = true,
			indent_marker = "│",
			last_indent_marker = "└",
			highlight = "NeoTreeIndentMarker",
			-- expander config, needed for nesting files
			with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
			expander_collapsed = " ",
			expander_expanded = " ",
			expander_highlight = "NeoTreeExpander",
		},
		icon = {
			folder_closed = " ",
			folder_open = " ",
			folder_empty = " ",
			-- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
			-- then these will never be used.
			default = "*",
			highlight = "NeoTreeFileIcon",
		},
		modified = {
			symbol = "[+]",
			highlight = "NeoTreeModified",
		},
		name = {
			trailing_slash = false,
			use_git_status_colors = true,
			highlight = "NeoTreeFileName",
		},
		git_status = {
			symbols = {
				-- Change type
				added = " ", -- or "✚", but this is redundant info if you use git_status_colors on the name
				modified = " ", -- or "", but this is redundant info if you use git_status_colors on the name
				deleted = "✖ ", -- this can only be used in the git_status source
				renamed = " ", -- this can only be used in the git_status source
				-- Status type
				untracked = " ",
				ignored = " ",
				unstaged = " ",
				staged = " ",
				conflict = " ",
			},
		},
	},
	window = {
		position = "left",
		width = 25,
		mapping_options = {
			noremap = true,
			nowait = true,
		},
		mappings = {
			["<space>"] = "noop",
			["<2-LeftMouse>"] = "open",
			-- ["<cr>"] = "open",
			["o"] = "open",
			["<esc>"] = "revert_preview",
			["<tab>"] = { "toggle_preview", config = { use_float = true } },
			--[[ ["S"] = "open_split",
      ["s"] = "open_vsplit", ]]
			["S"] = "split_with_window_picker",
			["s"] = "vsplit_with_window_picker",
			-- ["t"] = "open_tabnew",
			["<cr>"] = "open_drop",
			["t"] = "open_tab_drop",
			["w"] = "open_with_window_picker",
			["P"] = "noop", -- enter preview mode, which shows the current node without focusing
			["C"] = "close_node",
			["z"] = "close_all_nodes",
			["Z"] = "expand_all_nodes",
			["a"] = {
				"add",
				-- some commands may take optional config options, see `:h neo-tree-mappings` for details
				config = {
					show_path = "none", -- "none", "relative", "absolute"
				},
			},
			["A"] = "add_directory", -- also accepts the optional config.show_path option like "add".
			["d"] = "delete",
			["D"] = "delete",
			["r"] = "rename",
			["y"] = "copy_to_clipboard",
			["x"] = "cut_to_clipboard",
			["p"] = "paste_from_clipboard",
			["c"] = "copy", -- takes text input for destination, also accepts the optional config.show_path option like "add":
			-- ["c"] = {
			--  "copy",
			--  config = {
			--    show_path = "none" -- "none", "relative", "absolute"
			--  }
			--}
			["m"] = "move", -- takes text input for destination, also accepts the optional config.show_path option like "add".
			["q"] = "close_window",
			["R"] = "refresh",
			["?"] = "show_help",
			["<"] = "prev_source",
			[">"] = "next_source",
		},
	},
	nesting_rules = {},
	filesystem = {
		filtered_items = {
			visible = false, -- when true, they will just be displayed differently than normal items
			hide_dotfiles = false,
			hide_gitignored = true,
			hide_hidden = true, -- only works on Windows for hidden files/directories
			hide_by_name = {
				"node_modules",
			},
			hide_by_pattern = { -- uses glob style patterns
				"*.meta",
				"*/src/*/tsconfig.json",
			},
			always_show = { -- remains visible even if other settings would normally hide it
				".gitignored",
			},
			never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
				".DS_Store",
				"thumbs.db",
			},
			never_show_by_pattern = { -- uses glob style patterns
				--".null-ls_*",
			},
		},
		follow_current_file = true, -- This will find and focus the file in the active buffer every
		-- time the current file is changed while the tree is open.
		group_empty_dirs = true, -- when true, empty folders will be grouped together
		hijack_netrw_behavior = "open_default", -- netrw left alone, neo-tree does not handle opening dirs
		-- in whatever position is specified in window.position
		-- "open_current",  -- netrw disabled, opening a directory opens within the
		-- "open_default", -- netrw disabled, opening a directory opens neo-tree                -- window like netrw would, regardless of window.position
		use_libuv_file_watcher = true, -- This will use the OS level file watchers to detect changes
		-- instead of relying on nvim autocmd events.
		window = {
			mappings = {
				["<bs>"] = "navigate_up",
				["."] = "set_root",
				["H"] = "toggle_hidden",
				["/"] = "fuzzy_finder",
				["f"] = "filter_on_submit",
				["<c-x>"] = "clear_filter",
				["[g"] = "prev_git_modified",
				["]g"] = "next_git_modified",
			},
		},
	},
	buffers = {
		follow_current_file = true, -- This will find and focus the file in the active buffer every
		-- time the current file is changed while the tree is open.
		group_empty_dirs = true, -- when true, empty folders will be grouped together
		show_unloaded = true,
		window = {
			mappings = {
				["bd"] = "buffer_delete",
				["<bs>"] = "navigate_up",
				["."] = "set_root",
			},
		},
	},
	git_status = {
		window = {
			position = "float",
			mappings = {
				["A"] = "git_add_all",
				["gu"] = "git_unstage_file",
				["ga"] = "git_add_file",
				["gr"] = "git_revert_file",
				["gc"] = "git_commit",
				["gp"] = "git_push",
				["gg"] = "git_commit_and_push",
			},
		},
	},
})

require("window-picker").setup({
	include_current_win = true,
	use_winbar = "always", -- "always" | "never" | "smart"
	filter_rules = {
		-- filter using buffer options
		bo = {
			-- if the file type is one of following, the window will be ignored
			filetype = { "Outline", "NvimTree", "neo-tree", "notify" },

			-- if the buffer type is one of following, the window will be ignored
			buftype = { "terminal" },
		},

		-- filter using window options
		wo = {},

		-- if the file path contains one of following names, the window
		-- will be ignored
		file_path_contains = {},

		-- if the file name contains one of following names, the window will be
		-- ignored
		file_name_contains = {},
	},
})
