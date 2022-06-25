local wk_status_ok, wk = pcall(require, "which-key")
if not wk_status_ok then
  return
end

local M = {}

M.setup = function()
  local signs = {

    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignHint", text = "" },
    { name = "DiagnosticSignInfo", text = "" },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end

  local config = {
    virtual_text = true, -- disable virtual text
    signs = {
      active = signs, -- show signs
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focusable = true,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  }

  vim.diagnostic.config(config)

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
  })
end

M.lsp_g_keymaps = function(bufnr)
  local opts = {
    mode = "n",
    prefix = "",
    buffer = bufnr
  }
  local mappings = {
    g = {
      name = "LSP GoTo",
      D = { "<cmd>lua vim.lsp.buf.declaration()<CR>", "Declaration"},
      d = { "<cmd>lua vim.lsp.buf.definition()<CR>", "Definition"},
      I = { "<cmd>lua vim.lsp.buf.implementation()<CR>", "Implementation"},
      r = { "<cmd>lua vim.lsp.buf.references()<CR>", "References"},
      l = { ":lua require'popui.diagnostics-navigator'()<CR>", "Diagnostics"},
    },
    K = { "<cmd>lua vim.lsp.buf.hover()<CR>", "Hover Docs"},
  }
  wk.register(mappings, opts)
end

M.lsp_l_keymaps = function(bufnr)
  local opts = {
    mode = "n",
    prefix = "<leader>",
    buffer = bufnr
  }
  local mappings = {
    l = {
      name = "Lsp Actions",
      f = { "<cmd>lua vim.lsp.buf.formatting()<cr>", "Formatting"},
      i = { "<cmd>LspInfo<cr>", "Info"},
      I = { "<cmd>LspInstallInfo<cr>", "Installer Info"},
      j = { "<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>", "Next Diagnositic"},
      k = { "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>", "Prev Diagnositic"},
      r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename"},
      s = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Signature Help"},
      q = { "<cmd>lua vim.diagnostic.setloclist()<CR>", "Daignostic List"},
      a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action"}
    }
  }
  wk.register(mappings, opts)
end


M.rust_tools_keymaps = function()
  local opts = {
    mode = "n",
    prefix = "<leader>"
  }
  local mappings = {
    r = {
      name = "Rust",
      a = {":RustCodeAction<CR>", "Rust Code Action"},
      d = {":RustDebuggables<CR>", "Rust Debuggables"},
    }
  }
  wk.register(mappings, opts)
end

  -- keymap(bufnr, "n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)


M.on_attach = function(client, bufnr)
  local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
  if not status_cmp_ok then
    return
  end

  if client.name == "tsserver" then
    client.resolved_capabilities.document_formatting = false
  end

  if client.name == "sumneko_lua" then
    client.resolved_capabilities.document_formatting = false
  end

  M.capabilities = vim.lsp.protocol.make_client_capabilities()
  M.capabilities.textDocument.completion.completionItem.snippetSupport = true
  M.capabilities = cmp_nvim_lsp.update_capabilities(M.capabilities)

  M.lsp_g_keymaps(bufnr)
  M.lsp_l_keymaps(bufnr)
  if client.name == "rust_analyzer" then
    M.rust_tools_keymaps()
  end
  local status_ok, illuminate = pcall(require, "illuminate")
  if not status_ok then
    return
  end
  illuminate.on_attach(client)
end

return M
