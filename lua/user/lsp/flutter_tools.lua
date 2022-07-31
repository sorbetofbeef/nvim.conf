local flutter_status_ok, flutter_tools = pcall(require, "flutter-tools")
if not flutter_status_ok then
  return
end

local handlers_status_ok, handlers = pcall(require, "user.lsp.handlers")
if not handlers_status_ok then
  return
end

local telescope_status_ok, telescope = pcall(require, "telescope")
if not telescope_status_ok then
  return
end

flutter_tools.setup {
  ui = {
    notification_style = 'native',
    border = 'rounded',
  },
  debugger = {
    enabled = false,
  },
  decorations = {
    statusline = {
      app_version = true,
      device = true,
    },
  },
  dev_tools = {
    autostart = false,
  },
  flutter_path = "/Users/me/.local/share/flutter/bin/flutter",
  lsp = {
    color = {
      enabled = true,
      background = true,
    },
    on_attach = function (client, bufnr)
      handlers.on_attach(client, bufnr)
      require("user.keymaps").flutter_maps(bufnr)
    end,
    capabilities = handlers.capabilities,
  },
}

