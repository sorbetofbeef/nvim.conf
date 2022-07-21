-- vim.g.starry_italic_string = true
-- vim.g.starry_italic_keywords = true
-- vim.g.starry_italic_functions = true
-- vim.g.starry_borders = true
--
-- local colorscheme = "limestone"

--[[ require('nightfox').setup({
  options = {
    -- Compiled file's destination location
    -- compile_path = vim.fn.stdpath("cache") .. "/nightfox",
    -- compile_file_suffix = "_compiled", -- Compiled file suffix
    transparent = false,    -- Disable setting background
    terminal_colors = true, -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
    dim_inactive = true,   -- Non focused panes set to alternative background
    styles = {              -- Style to be applied to different syntax groups
      comments = "italic",    -- Value is any valid attr-list value `:help attr-list`
      conditionals = "NONE",
      constants = "italic,bold",
      functions = "italic",
      keywords = "bold",
      numbers = "NONE",
      operators = "NONE",
      strings = "italic",
      types = "bold",
      variables = "bold",
    },
    inverse = {             -- Inverse highlight for different types
      match_paren = false,
      visual = false,
      search = false,
    },
    modules = {
      aerial = false,
      barbar = false,
      cmp = true,
      dap_ui = true,
      dashboard = false,
      diagnostic = {
        enable = true,
        background = true,
      },
      fern = false,
      fidget = false,
      gitgutter = true,
      gitsigns = true,
      glyph_palette = true,
      hop = false,
      illuminate = true,
      lightspeed = false,
      lsp_saga = false,
      lsp_trouble = false,
      modes = true,
      native_lsp = true,
      neogit = true,
      neotree = false,
      notify = false,
      nvimtree = true,
      pounce = false,
      sneak = false,
      symbol_outline = true,
      telescope = true,
      treesitter = true,
      tsrainbow = false,
      whichkey = true,
    },
  },
}) ]]

--[[ vim.g.rasmus_italic_keywords = false
vim.g.rasmus_italic_comments = true
vim.g.rasmus_italic_functions = true
vim.g.rasmus_italic_booleans = false
vim.g.rasmus_italic_variables = false

vim.g.rasmus_bold_keywords = true
vim.g.rasmus_bold_comments = false
vim.g.rasmus_bold_functions = true
vim.g.rasmus_bold_booleans = true
vim.g.rasmus_bold_variables = true


vim.g.rasmus_transparent = true

require('kanagawa').setup({
    undercurl = true,           -- enable undercurls
    commentStyle = { italic = true },
    functionStyle = { bold = true},
    keywordStyle = { italic = true},
    statementStyle = { bold = true },
    typeStyle = { bold = true},
    variablebuiltinStyle = { italic = true},
    specialReturn = true,       -- special highlight for the return keyword
    specialException = true,    -- special highlight for exception handling keywords
    transparent = false,        -- do not set background color
    dimInactive = true,        -- dim inactive window `:h hl-NormalNC`
    globalStatus = true,       -- adjust window separators highlight for laststatus=3
    colors = {},
    overrides = {},
})

vim.opt.laststatus = 3
vim.opt.fillchars:append({
    horiz = '━',
    horizup = '┻',
    horizdown = '┳',
    vert = '┃',
    vertleft = '┨',
    vertright = '┣',
    verthoriz = '╋',
})
require'kanagawa'.setup({ globalStatus = true, ... })
]]
-- vim.cmd("colorscheme kanagawa")
vim.g.material_style = "darker"
--local colors = require("material.colors")

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
    keywords = true, -- Enable italic keywords
    functions = false, -- Enable italic functions
    strings = true, -- Enable italic strings
    variables = false, -- Enable italic variables
  },
  contrast_filetypes = {
    "Outline",
    "NvimTree"
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

-- setup must be called before loading
local colorscheme = "material"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  return
end

