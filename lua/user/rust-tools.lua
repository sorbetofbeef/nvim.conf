local status_ok, rt = pcall(require, "rust-tools")
if not status_ok then
  return
end

local lsp_status_ok, handlers = pcall(require, "user.lsp.handlers")
if not lsp_status_ok then
  return
end

local extension_path = vim.env.HOME .. '/.local/share/nvim/dapinstall/codelldb/extension/'
local codelldb_path = extension_path .. 'adapter/codelldb'
local liblldb_path = extension_path .. 'lldb/lib/liblldb.dylib'

local rust_opts = {
  tools = {
    autoSetHints = true,
    hover_with_actions = true,
    runnables = { use_telescope = true },
    debuggables = { use_telescope = true },
    inlay_hints = {
      show_parameter_hints = false,
      parameter_hints_prefix = "",
      other_hints_prefix = "",
    },
    hover_actions = {
      border = "single",
    },
  },
  dap = {
    adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
    --adapter = {
    --type = 'executable',
    --command = 'lldb-vscode',
    --name = "rt_lldb"
    --}
  },
  runnables = { use_telescope = true },
  debuggables = { use_telescope = true },
  server = {
    --cmd = {"/home/sharks/source/dotfiles/misc/misc/rust-analyzer-wrapper"},
    on_attach = handlers.on_attach,
    capabilities = handlers.updated_capabilities,
    settings = {
      -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
      ["rust-analyzer"] = {
        updates = { channel = "stable" },
        assist = {
          importGroup = true,
          importMergeBehaviour = "full",
          importPrefix = "by_crate",
        },

        callInfo = {
          full = true,
        },

        cargo = {
          allFeatures = true,
          autoreload = true,
          loadOutDirsFromCheck = true,
        },

        checkOnSave = {
          command = "clippy",
          allFeatures = true,
          extraArgs = { "--tests" },
        },

        completion = {
          addCallArgumentSnippets = true,
          addCallParenthesis = true,
          postfix = {
            enable = true,
          },
          autoimport = {
            enable = true,
          },
        },

        diagnostics = {
          enable = true,
          enableExperimental = true,
        },

        hoverActions = {
          enable = true,
          debug = true,
          gotoTypeDef = true,
          implementations = true,
          run = true,
          linksInHover = true,
        },

        inlayHints = {
          chainingHints = true,
          parameterHints = true,
          typeHints = true,
        },

        lens = {
          enable = true,
          debug = true,
          implementations = true,
          run = true,
          methodReferences = true,
          references = true,
        },

        notifications = {
          cargoTomlNotFound = true,
        },

        procMacro = {
          enable = true,
        },
      }, -- ["rust-analyzer"]
    }, -- settings
  }, -- lsp server
}

rt.setup(rust_opts)
