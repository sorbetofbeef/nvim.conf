local M = {}
M.setup = function(subTheme)

  if subTheme == nil then
    subTheme = "kanagawa"
  end

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

  vim.opt.fillchars:append({
      horiz = '━',
      horizup = '┻',
      horizdown = '┳',
      vert = '┃',
      vertleft = '┨',
      vertright = '┣',
      verthoriz = '╋',
  })

  vim.cmd("colorscheme"..subTheme)
end

return M
