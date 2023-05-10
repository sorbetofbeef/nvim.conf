local status_ok, dressing = pcall(require, "dressing")
if not status_ok then
	return
end

local function get_prompt_text(prompt, default_prompt)
	local prompt_text = prompt or default_prompt
	if prompt_text:sub(-1) == ":" then
		prompt_text = "[" .. prompt_text:sub(1, -2) .. "]"
	end
	return prompt_text
end

dressing.setup({
	input = {
		-- Set to false to disable the vim.ui.input implementation
		enabled = true,

		-- Default prompt string
		default_prompt = "Input",

		-- Can be 'left', 'right', or 'center'
		prompt_align = "center",

		-- When true, <Esc> will close the modal
		insert_only = true,

		-- These are passed to nvim_open_win
		anchor = "NW",
		border = "rounded",
		-- 'editor' and 'win' will default to being centered
		relative = "cursor",

		-- These can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
		prefer_width = 0.1,
		width = nil,
		-- min_width and max_width can be a list of mixed types.
		-- min_width = {20, 0.2} means "the greater of 20 columns or 20% of total"
		max_width = 20,
		min_width = 0.1,

		win_options = {
			-- Window transparency (0-100)
			winblend = 10,
			-- Change default highlight groups (see :help winhl)
			winhighlight = "Normal:Normal,FloatBorder:Normal",
		},

		override = function(conf)
			-- This is the config that will be passed to nvim_open_win.
			-- Change values here to customize the layout
			return conf
		end,

		-- see :help dressing_get_config
		get_config = nil,
	},

	select = {

		-- Set to false to disable the vim.ui.select implementation
		enabled = true,

		-- Priority list of preferred vim.select implementations
		-- backend = { "telescope", "fzf_lua", "fzf", "builtin", "nui" },
		backend = { "nui", "builtin" },

		-- Trim trailing `:` from prompt
		trim_prompt = true,

		-- Options for telescope selector
		-- These are passed into the telescope picker directly. Can be used like:
		-- telescope = require('telescope.themes').get_ivy({...})
		-- telescope = require("telescope.themes").get_cursor({ initial_mode = "normal" }),

		-- Options for nui Menu
		nui = {
			postition = "50%",
			size = nil, -- change position for codeaction selection
			relative = "win",
			border = {
				style = "rounded",
				text = {
					top_align = "left",
				},
			},
			buf_options = {
				swapfile = false,
				filetype = "DressingSelect",
			},
			win_options = {
				winblend = 10,
				winhighlight = "Normal:Normal,FloatBorder:Normal",
			},
			max_width = 80,
			max_height = 40,
			min_width = 40,
			min_height = 10,
		},

		-- Options for built-in selector
		builtin = {
			-- These are passed to nvim_open_win
			anchor = "NW",
			border = "rounded",
			-- 'editor' and 'win' will default to being centered
			relative = "win",

			win_options = {
				-- Window transparency (0-100)
				winblend = 10,
				-- Change default highlight groups (see :help winhl)
				winhighlight = "",
			},

			-- These can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
			-- the min_ and max_ options can be a list of mixed types.
			-- max_width = {140, 0.8} means "the lesser of 140 columns or 80% of total"
			width = nil,
			max_width = { 140, 0.8 },
			min_width = { 40, 0.2 },
			height = nil,
			max_height = 0.9,
			min_height = { 10, 0.2 },

			override = function(conf)
				-- This is the config that will be passed to nvim_open_win.
				-- Change values here to customize the layout
				return conf
			end,
		},

		-- Used to override format_item. See :help dressing-format
		format_item_override = {},

		-- see :help dressing_get_config
		get_config = function(opts)
			if opts.kind == "codeaction" then
				return {
					backend = "nui",
					nui = {
						position = {
							row = 1,
							col = 0,
						},
						border = {
							style = "rounded",
							top = get_prompt_text(opts.prompt, "[Select]"),
						},
						relative = "cursor",
						max_width = 40,
						win_options = {
							winblend = 10,
							winhighlight = "Normal:StatusLine,FloatBorder:StatusLine",
							-- winhighlight = "Normal:Normal,FloatBorder:Normal",
						},
					},
				}
			end
		end,
	},
})
