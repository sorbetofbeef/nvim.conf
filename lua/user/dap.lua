local dap_status_ok, dap = pcall(require, "dap")
if not dap_status_ok then
  return
end

local dap_ui_status_ok, dapui = pcall(require, "dapui")
if not dap_ui_status_ok then
  return
end

local dap_install_status_ok, dap_install = pcall(require, "dap-install")
if not dap_install_status_ok then
  return
end

dap_install.setup {}

dap_install.config("python", {})
dap_install.config("lua", {})
dap_install.config("go", {})
dap_install.config("codelldb", {})
-- add other configs here

-- If you want to use this for Rust and C, add something like this:

dapui.setup {

  layout = {
    elements = {
      {
        id = "scopes",
        size = 0.25, -- Can be float or integer > 1
        position = "right",
      },
      {
        id = "breakpoints",
        size = 0.25,
        position = "right",
      },
    },
  },
}

vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticSignError", linehl = "", numhl = "" })

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end

dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end

dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end
