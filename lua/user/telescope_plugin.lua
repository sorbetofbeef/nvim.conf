local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
	return
end

local actions = require("telescope.actions")
local trouble = require("trouble.providers.telescope")
local builtin = require("telescope.builtin")
local themes = require("telescope.themes")

telescope.setup({
	extensions = {
		["ui-select"] = {
			themes.get_cursor({ previewer = false, winblend = 10, initial_mode = "normal" }),
		},
		["luasnip"] = {
			themes.get_cursor({ previewer = true, winblend = 10, initial_mode = "normal" }),
		},
		["projects"] = {
			themes.get_ivy({ initial_mode = "normal" }),
		},
	},
	defaults = {
		prompt_prefix = " ",
		selection_caret = " ",
		path_display = { "smart" },
		file_ignore_patterns = { ".git/", "node_modules" },

		mappings = {
			i = {
				["<Down>"] = actions.cycle_history_next,
				["<Up>"] = actions.cycle_history_prev,
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
				["<c-t>"] = trouble.open_with_trouble,
			},
			n = {
				["<c-t>"] = trouble.open_with_trouble,
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
			},
		},
	},
	pickers = {
		live_grep = {
			themes.get_dropdown({ previewer = true, initial_mode = "normal" }),
		},
		grep_string = {
			themes.get_dropdown({ previewer = true, initial_mode = "normal" }),
		},
		find_files = {
			themes.get_dropdown({ previewer = false, initial_mode = "normal" }),
		},
		buffers = {
			themes.get_dropdown({ previewer = false, initial_mode = "normal" }),
			initial_mode = "normal",
			mappings = {
				n = {
					["D"] = actions.delete_buffer,
				},
			},
		},
		-- planets = {
		-- 	show_pluto = true,
		-- 	show_moon = true,
		-- },
		colorscheme = {
			themes.get_dropdown({ previewer = true, initial_mode = "normal" }),
		},
		lsp_references = {
			theme = "cursor",
			initial_mode = "normal",
		},
		lsp_definitions = {
			theme = "cursor",
			initial_mode = "normal",
		},
		lsp_declarations = {
			theme = "cursor",
			initial_mode = "normal",
		},
		lsp_implementations = {
			theme = "cursor",
			initial_mode = "normal",
		},
	},
})

telescope.load_extension("ui-select")
telescope.load_extension("project")
telescope.load_extension("luasnip")

local flutter_okay, _ = pcall(telescope.load_extension, "flutter")
if not flutter_okay then
	return
end
