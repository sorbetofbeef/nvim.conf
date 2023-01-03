local installer_status_ok, _ = pcall(require, "user.lsp.lsp-installer")
if not installer_status_ok then
  return
end

local handlers_status_ok, handlers = pcall(require, "user.lsp.handlers")
if not handlers_status_ok then
  return
end
handlers.setup()

local refactor_status_ok, _ = pcall(require, "user.lsp.refactoring")
if not refactor_status_ok then
  return
end

-- local inlay_hints_ok, _ = pcall(require, "user.lsp.lsp_inlayhints")
-- if not inlay_hints_ok then
--   return
-- end

local sigs_ok, _ = pcall(require, "user.lsp.lsp_signature")
if not sigs_ok then
  return
end
