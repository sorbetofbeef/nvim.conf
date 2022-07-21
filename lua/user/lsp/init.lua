local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

local installer_status_ok, _ = pcall(require, "user.lsp.lsp-installer")
if not installer_status_ok then
  return
end

local handlers_status_ok, handlers = pcall(require, "user.lsp.handlers")
if not handlers_status_ok then
  return
end
handlers.setup()

local null_status_ok, _ = pcall(require, "user.lsp.null-ls")
if not null_status_ok then
  return
end

local flutter_status_ok, _ = pcall(require, "user.lsp.flutter_tools")
if not flutter_status_ok then
  return
end

local refactor_status_ok, _ = pcall(require, "user.lsp.refactoring")
if not refactor_status_ok then
  return
end

