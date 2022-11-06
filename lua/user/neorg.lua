local neorg_status_ok, neorg = pcall(require, "neorg")
if not neorg_status_ok then
  return
end

neorg.setup {
  load = {
    ["core.defaults"] = {},
    ["core.norg.dirman"] = {
      config = {
        workspaces ={
          hacking = "~/Documents/hacking",
          rust = "~/Documents/rust",
          flutter = "~/Documents/flutter_dart",
          bartending = "~/Documents/bartending",
          gtd = "~/Documents/notes"
        },
        index = "index.norg"
      },
    },
    --[[ ["core.neorg.treesitter"] = {}, ]]
    ["core.norg.concealer"] = {},
    ["core.gtd.base"] = {
      config = {
        workspace = "gtd"
      }
    },
    ["core.gtd.ui"] = {},
    ["core.gtd.queries"] = {},
    ["core.gtd.helpers"] = {},
    ["core.norg.completion"] = {
      config = {
        engine = "nvim-cmp"
      }
    },
    ["core.integrations.nvim-cmp"] = {},
    ["core.norg.qol.toc"] = {},
    ["core.integrations.treesitter"] = {},
    ["core.export.markdown"] = {},
    ["external.kanban"] = {},
  }
}

