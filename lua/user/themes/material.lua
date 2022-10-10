local M = {}

M.setup = function(subTheme)

  vim.g.material_style = subTheme

  require("material").setup({
    contrast = {
      sidebars = false,
      floating_windows = false,
      line_numbers = false,
      sign_column = false,
      cursor_line = false,
      non_current_windows = false,
      popup_menu = false,
    },
    italics = {
      comments = true, -- Enable italic comments
      keywords = false, -- Enable italic keywords
      functions = true, -- Enable italic functions
      strings = true, -- Enable italic strings
      variables = false, -- Enable italic variables
    },
    contrast_filetypes = {
      "Outline",
      "neo-tree",
      -- "NvimTree",
      "dapui_scopes",
      "dapui_stacks",
      "dapui_watches",
      "dapui_breakpoints",
      "dapui-repl",
      "dapui_console",
    },
    disable = {
      background = false,
      term_colors = false,
      eob_lines = false,
    },
    plugins = { -- Here, you can disable(set to false) plugins that you don't use or don't want to apply the theme to
  		trouble = true,
  		nvim_cmp = true,
  		neogit = true,
  		gitsigns = true,
  		git_gutter = true,
  		telescope = true,
  		nvim_tree = true,
  		sidebar_nvim = true,
  		lsp_saga = true,
  		nvim_dap = true,
  		nvim_navic = true,
  		which_key = true,
  		sneak = true,
  		hop = true,
  		indent_blankline = true,
  		nvim_illuminate = true,
  		mini = true,
  	},
  })

  vim.cmd("colorscheme material")
end

return M
