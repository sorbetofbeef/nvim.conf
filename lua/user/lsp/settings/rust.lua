local status_ok, rt = pcall(require, "rust-tools")
if not status_ok then
  return
end

local handler_status_ok, handlers = pcall(require, "user.lsp.handlers")
if not handler_status_ok then
  return
end

local extension_path = vim.env.HOME .. '/.local/share/nvim/dapinstall/codelldb/extension/'
local codelldb_path = extension_path .. 'adapter/codelldb'
local liblldb_path = extension_path .. 'lldb/lib/liblldb.dylib'

local rust_opts = {
  tools = {
    on_initialized = function ()
      vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "CursorHold", "InsertLeave" }, {
        pattern = { "*.rs" },
        callback = function()
          vim.lsp.codelens.refresh()
        end,
      })
    end,
    autoSetHints = true,
    hover_with_actions = true,
    -- runnables = { use_telescope = false },
    -- debuggables = { use_telescope = false },
    inlay_hints = {
      show_parameter_hints = true,
      show_variable_name = true,
      parameter_hints_prefix = " << ",
      other_hints_prefix = " >> ",
    },
    hover_actions = {
      border = "rounded",
      auto_focus = true,
      width = 60,
      height = 30
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
  -- runnables = { use_telescope = true },
  -- debuggables = { use_telescope = true },
  server = {
    cmd = { os.getenv "HOME" .. "/.local/bin/rust-analyzer" },
    on_attach = handlers.on_attach,
    capabilities = handlers.capabilities,
    --cmd = {"/home/sharks/source/dotfiles/misc/misc/rust-analyzer-wrapper"},
    settings = {
      -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
      ["rust-analyzer"] = {
        updates = { channel = "stable" },
        assist = {
          expressionFillDefault = "todo",
          --[[ importGroup = true,
          importGranularity = "module",
          importPrefix = "self", ]]
        },

        --[[ callInfo = {
          full = true,
        }, ]]

        cargo = {
          features = "all",
          autoreload = true,
          loadOutDirsFromCheck = true,
        },

        checkOnSave = {
          command = "clippy",
          features = "all",
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

        imports = {
          granularity = {
            enable = true,
          },
          enableExperimental = true,
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
  } -- lsp server
}

rt.setup(rust_opts)
