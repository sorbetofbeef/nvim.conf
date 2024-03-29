return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		{
			"s1n7ax/nvim-window-picker",
			version = "v1.*",
			config = function()
				require("window-picker").setup({
					autoselect_one = true,
					include_current = false,
					filter_rules = {
						-- filter using buffer options
						bo = {
							-- if the file type is one of following, the window will be ignored
							filetype = { "Trouble", "Outline", "neo-tree", "neo-tree-popup", "notify" },

							-- if the buffer type is one of following, the window will be ignored
							buftype = { "terminal", "quickfix" },
						},
					},
					other_win_hl_color = "#e35e4f",
				})
			end,
		},
		"MunifTanjim/nui.nvim",
	},
	config = function()
		vim.g.neo_tree_remove_legacy_commands = 1

		local left = require("user.icons").ui.LeftThinCircle
		local right = require("user.icons").ui.RightThinCircle

		-- If you want icons for diagnostic errors, you'll need to define them somewhere:
		vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
		vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
		vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
		vim.fn.sign_define("DiagnosticSignHint", { text = " ", texthl = "DiagnosticSignHint" })
		-- NOTE: this is changed from v1.x, which used the old style of highlight groups
		-- in the form "LspDiagnosticsSignWarning"

		require("neo-tree").setup({
			sources = {
				"filesystem",
				-- "buffers",
				-- "git_status",
				-- "document_symbols",
			},
			source_selector = {
				winbar = false, -- toggle to show selector on winbar
				statusline = false, -- toggle to show selector on statusline
				show_scrolled_off_parent_node = true, -- this will replace the tabs with the parent path
				-- of the top visible node when scrolled down.
				sources = { -- falls back to source_name if nil
					{
						source = "filesystem",
						display_name = "  ",
					},
					-- {
					-- 	source = "buffers",
					-- 	display_name = "  ",
					-- },
					-- {
					-- 	source = "git_status",
					-- 	display_name = "  ",
					-- },
					-- {
					-- 	source = "document_symbols",
					-- 	display_name = "  ",
					-- },
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
			open_files_in_last_window = true,
			sort_case_insensitive = false, -- used when sorting files and directories in the tree
			sort_function = nil, -- use a custom function for sorting files and directories in the tree
			-- sort_function = function (a,b)
			--       if a.type == b.type then
			--           return a.path > b.path
			--       else
			--           return a.type > b.type
			--       end
			--   end , -- this sorts files and directories descendantly
			-- event_handlers = {
			-- 	{
			-- 		event = "file_opened",
			-- 		handler = function(file_opened)
			-- 			--auto close
			-- 			require("neo-tree").close_all()
			-- 		end,
			--   },
			-- },
			default_component_configs = {
				container = {
					enable_character_fade = true,
				},
				indent = {
					indent_size = 1,
					padding = 0, -- extra padding on left hand side
					-- indent guides
					with_markers = true,
					indent_marker = "╎",
					last_indent_marker = "╵",
					highlight = "NeoTreeFileIcon",
					-- expander config, needed for nesting files
					with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
					expander_collapsed = "└",
					expander_expanded = "╵",
					expander_highlight = "NeoTreeFileIcon",
					-- expander_highlight = "NeoTreeExpander",
				},
				icon = {
					folder_closed = "",
					folder_open = "",
					folder_empty = "",
					-- folder_closed = " ",
					-- folder_open = " ",
					-- folder_empty = " ",
					-- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
					-- then these will never be used.
					default = " ",
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
						modified = "󰐙 ", -- or "", but this is redundant info if you use git_status_colors on the name
						deleted = "✖ ", -- this can only be used in the git_status source
						renamed = "󰰞 ", -- this can only be used in the git_status source
						-- Status type
						untracked = " ",
						ignored = " ",
						unstaged = "󰛲 ",
						staged = " ",
						conflict = " ",
					},
				},
			},
			window = {
				position = "left",
				width = 30,
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
					["P"] = { "toggle_preview", config = { use_float = true } },
					--[[ ["S"] = "open_split",
      ["s"] = "open_vsplit", ]]
					["S"] = "split_with_window_picker",
					["s"] = "vsplit_with_window_picker",
					["t"] = "open_tabnew",
					["<cr>"] = "open",
					-- ["t"] = "open_tab_drop",
					-- ["w"] = "open_with_window_picker",
					["C"] = "close_node",
					["z"] = "close_all_nodes",
					-- ["Z"] = "show_hidden",
					["a"] = {
						"add",
						-- some commands may take optional config options, see `:h neo-tree-mappings` for details
						config = {
							show_path = "none", -- "none", "relative", "absolute"
						},
					},
					["A"] = "add_directory", -- also accepts the optional config.show_path option like "add".
					["d"] = "noop",
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
			document_symbols = {
				server_filter = "all",
				follow_cursor = true,
			},
			filesystem = {
				filtered_items = {
					visible = false, -- when true, they will just be displayed differently than normal items
					hide_dotfiles = false,
					hide_gitignored = false,
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
				follow_current_file = {
					enabled = false, -- This will find and focus the file in the active buffer every
					leave_dirs_open = false,
					-- time the current file is changed while the tree is open.
				},
				group_empty_dirs = false, -- when true, empty folders will be grouped together
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
						["H"] = "noop",
						["/"] = "fuzzy_finder",
						["f"] = "filter_on_submit",
						["<c-x>"] = "clear_filter",
						["[g"] = "prev_git_modified",
						["]g"] = "next_git_modified",
					},
				},
			},
			-- buffers = {
			-- 	follow_current_file = true, -- This will find and focus the file in the active buffer every
			-- 	-- time the current file is changed while the tree is open.
			-- 	group_empty_dirs = true, -- when true, empty folders will be grouped together
			-- 	show_unloaded = false,
			-- 	window = {
			-- 		mappings = {
			-- 			["bd"] = "buffer_delete",
			-- 			["<bs>"] = "navigate_up",
			-- 			["."] = "set_root",
			-- 		},
			-- 	},
			-- },
			-- git_status = {
			-- 	window = {
			-- 		position = "float",
			-- 		mappings = {
			-- 			["A"] = "git_add_all",
			-- 			["gu"] = "git_unstage_file",
			-- 			["ga"] = "git_add_file",
			-- 			["gr"] = "git_revert_file",
			-- 			["gc"] = "git_commit",
			-- 			["gp"] = "git_push",
			-- 			["gg"] = "git_commit_and_push",
			-- 		},
			-- 	},
			-- },
		})
	end,
}
