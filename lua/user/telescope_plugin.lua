local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

local actions = require("telescope.actions")
local trouble = require("trouble.providers.telescope")
local builtin = require('telescope.builtin')
local themes = require('telescope.themes')


telescope.setup {
  extensions = {
    ["ui-select"] = {
      themes.get_cursor({ winblend=10 }),
    },
    ["projects"] = {
      themes.get_ivy(),
    }
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
}

telescope.load_extension("ui-select")
telescope.load_extension("project")
telescope.load_extension("luasnip")
telescope.load_extension("flutter")
