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
    notification_style = 'native'
  },
  debugger = {
    enabled = true,
  },
  decorations = {
    statusline = {
      app_version = true,
      device = true,
    },
  },
  dev_tools = {
    autostart = true,
  },
  flutter_path = "/Users/me/.local/share/flutter/bin/flutter",
  lsp = {
    on_attach = handlers.on_attach,
    capabilities = handlers.capabilities,
  },
}

telescope.load_extension("flutter")


