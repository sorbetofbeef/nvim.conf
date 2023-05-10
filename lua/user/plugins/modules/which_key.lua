return {
  "folke/which-key.nvim",
  config = function ()
  require("which-key").setup({
    layout = {
      height = { min = 4, max = 25 }, -- min and max height of the columns
      width = { min = 20, max = 50 }, -- min and max width of the columns
      spacing = 3, -- spacing between columns
      align = "center", -- align columns left, center or right
      winblend = 50,
    },
    ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
  })
end,
}
