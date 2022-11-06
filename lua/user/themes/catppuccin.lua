local M = {}

local okay, cat = pcall(require, "catppuccin")
if not okay then
  return
end

M.setup = function(variant)

  vim.g.catppuccin_flavour = variant

  cat.setup({
    term_colors = true,
    dim_inactive = {
      enabled = true,
      shade = "dark",
      percentage = 0.15
    },
    styles = {
      comments = { "italic" },
      conditionals = { "italic" },
      loops = { "bold" },
      strings = { "italic" },
      functions = { "italic", "bold" },
      numbers = { "bold" },
      properties = { "bold" },
      variables = { "bold" },
      types = { "italic", "bold" },
      operators = { "bold" },
    },
    integrations = {
      which_key = true,
      lsp_trouble = true,
      symbols_outline = true,
      neotree = true,
      gitsigns = true,
      markdown = true,
      cmp = true,
      treesitter_context = true,
      telescope = true,
      navic = {
        enabled = true,
        custom_bg = "NONE"
      },
      fidget = true,
    },
    native_lsp = {
      enabled = true,
      virtual_text = {
        errors = { "italic" },
        hints = { "italic" },
        warnings = { "italic" },
        information = { "italic" },
      },
      underlines = {
        errors = { "underline" },
        hints = { "underline" },
        warnings = { "underline" },
        information = { "underline" },
      },
    },
  })

  vim.cmd("colorscheme catppuccin")
end

return M
