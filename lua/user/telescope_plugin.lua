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
			n = { ["<c-t>"] = trouble.open_with_trouble },
		},
	},
	pickers = {
		live_grep = {
			theme = "dropdown",
		},
		grep_string = {
			theme = "dropdown",
		},
		find_files = {
			theme = "dropdown",
			previewer = false,
		},
		buffers = {
			theme = "dropdown",
			previewer = false,
			initial_mode = "normal",
		},
		planets = {
			show_pluto = true,
			show_moon = true,
		},
		colorscheme = {
			theme = "dropdown",
			-- enable_preview = true,
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
