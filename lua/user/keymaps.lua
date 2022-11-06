local status_ok, wk = pcall(require, "which-key")

if not status_ok then
	return
end

-- Exported functions
local M = {}

-- Shorten function name
local keymap = vim.keymap.set

--Remap space as leader key
keymap("n", "<Space>", "<Nop>", { silent = true })
vim.g.mapleader = " "

local standard_maps = function()
	local opts = {
		silent = true,
		noremap = true,
	}

	-- Normal --
	-- Better window navigation
	keymap("n", "<C-h>", "<C-w>h", opts)
	keymap("n", "<C-j>", "<C-w>j", opts)
	keymap("n", "<C-k>", "<C-w>k", opts)
	keymap("n", "<C-l>", "<C-w>l", opts)

	-- Resize with arrows
	keymap("n", "<C-Up>", "<cmd>resize -2<CR>", opts)
	keymap("n", "<C-Down>", "<cmd>resize +2<CR>", opts)
	keymap("n", "<C-Left>", "<cmd>vertical resize -2<CR>", opts)
	keymap("n", "<C-Right>", "<cmd>vertical resize +2<CR>", opts)

	keymap("i", "<C-k>", "<Up>", opts)
	keymap("i", "<C-j>", "<Down>", opts)
	keymap("i", "<C-h>", "<Left>", opts)
	keymap("i", "<C-l>", "<Right>", opts)

	keymap("n", "<C-s>", "<cmd>vsplit<cr>", opts)

	-- Buffers --
	keymap("n", "gl", ":bnext<CR>", opts)
	keymap("n", "gh", ":bprevious<CR>", opts)

	-- Tabs --
	keymap("n", "gj", ":tabnext<CR>", opts)
	keymap("n", "gk", ":tabprevious<CR>", opts)
	keymap("n", "gt", ":tabnew<CR>", opts)

	-- Movement --
	-- Sane movement defaults that works on long wrapped lines
	local expr = { expr = true, noremap = false, silent = false }
	keymap("n", "j", "(v:count ? 'j' : 'gj')", expr)
	keymap("n", "k", "(v:count ? 'k' : 'gk')", expr)
	keymap("", "<Down>", "(v:count ? 'j' : 'gj')", expr)
	keymap("", "<Up>", "(v:count ? 'k' : 'gk')", expr)

	keymap("n", "x", '"_x', opts) -- delete char without yank
	keymap("x", "x", '"_x', opts) -- delete visual selection without yank

	-- paste in visual mode and keep available
	keymap("x", "p", [['pgv"'.v:register.'y`>']], expr)
	keymap("x", "P", [['Pgv"'.v:register.'y`>']], expr)
	-- select last inserted text
	keymap("n", "gV", [['`[' . strpart(getregtype(), 0, 1) . '`]']], expr)

	keymap("i", "jk", "<ESC>", opts)
	keymap("x", "jk", "<ESC>", opts)

	keymap("x", "<", "<gv", opts)
	keymap("x", ">", ">gv", opts)
end

local bracket_maps = function()
	local opts = {
		mode = "n",
	}

	local mappings = {
		["["] = {
      name = "which_key_ignore",
			h = { "<cmd>lua require('harpoon.ui').nav_prev()<cr>", "Harpoon Backward" },
		},
		["]"] = {
      name = "which_key_ignore",
			h = { "<cmd>lua require('harpoon.ui').nav_next()<cr>", "Harpoon Forward" },
		},
	}

	wk.register(mappings, opts)
end

local plug_maps = function()
	local opts = {
		mode = "n",
		prefix = "<leader>",
	}

	local mappings = {
		-- Plugins --
		-- Alpha
		["<c-h>"] = { "<cmd>Alpha<CR>", "Go Home" },
		-- NvimTree
		e = { "<cmd>Neotree toggle<CR>", "Explorer" },
		-- Harpoon
		h = {
			name = "Harpoon",
			a = { "<cmd>lua require('harpoon.mark').add_file()<cr>", "Add File" },
			h = { "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", "Menu" },
		},

		-- Telescope
		b = { "<cmd>Telescope buffers<CR>", "Buffers" },
		f = {
			name = "Find",
			f = { "<cmd>Telescope find_files<CR>", "Find File" },
			h = { "<cmd>Telescope help_tags<CR>", "Find Help" },
			c = { "<cmd>Telescope colorscheme<CR>", "Find Colorschemes" },
			t = { "<cmd>Telescope live_grep<CR>", "Find Text" },
			p = { "<cmd>Telescope projects<CR>", "Find Projects" },
			k = { "<cmd>Telescope keymaps<CR>", "Find Keymaps" },
		},

		-- Symbol Outline
		o = { "<cmd>SymbolsOutline<CR>", "Symbols Panel" },

		-- DAP
		D = {
			name = "Debug",
			c = { "<cmd>lua require('dap').continue()<cr>", "Continue" },
			i = { "<cmd>lua require('dap').step_into()<cr>", "Step Into" },
			o = { "<cmd>lua require('dap').step_over()<cr>", "Step Over" },
			O = { "<cmd>lua require('dap').step_out()<cr>", "Step Out" },
			r = { "<cmd>lua require('dap').repl.toggle()<cr>", "Repl" },
			l = { "<cmd>lua require('dap').run_last()<cr>", "Run Last" },
			u = { "<cmd>lua require('dapui').toggle()<cr>", "Toggle UI" },
			t = { "<cmd>lua require('dap').terminate()<cr>", "Terminate" },
		},

		-- Clear highlights
		["<ESC>"] = { "<cmd>nohlsearch<CR>", "which_key_ignore" },
		-- LSP Info
		l = {
			name = "LSP",
			i = { "<cmd>LspInfo<cr>", "Info" },
			I = { "<cmd>Mason<cr>", "Mason UI" },
		},

		-- Close buffers
		["C"] = { "<cmd>Bdelete!<CR>", "which_key_ignore" },
		["c"] = { "<cmd>Bdelete<CR>", "which_key_ignore" },
		["Q"] = { "<cmd>quit!<CR>", "which_key_ignore" },
		["q"] = { "<cmd>quit<CR>", "which_key_ignore" },
		["W"] = { "<cmd>wqa!<CR>", "which_key_ignore" },
		["w"] = { "<cmd>wa<CR>", "which_key_ignore" },

		t = {
			name = "Terminal",
			t = { ":ToggleTerm<CR>", "Term" },
			["1"] = { "<cmd>lua _TERM_ONE_TOGGLE()<CR>", "Term 1" },
			["2"] = { "<cmd>lua _TERM_TWO_TOGGLE()<CR>", "Term 2" },
			["3"] = { "<cmd>lua _TERM_THREE_TOGGLE()<CR>", "Term 3" },
			["4"] = { "<cmd>lua _TERM_FOUR_TOGGLE()<CR>", "Term 4" },
			["5"] = { "<cmd>lua _TERM_FIVE_TOGGLE()<CR>", "Term 5" },
			g = { "<cmd>lua _LAZYGIT_TOGGLE()<CR>", "Lazygit" },
			d = { "<cmd>lua _LAZYDOCKER_TOGGLE()<CR>", "Lazydocker" },
			h = { "<cmd>lua _HTOP_TOGGLE()<CR>", "htop" },
		},

		d = {
			name = "Trouble",
			q = { ":Trouble quickfix<cr>", "Qucikfix List" },
			d = { ":Trouble quickfix<cr>", "Qucikfix List" },
		},
	}

	wk.register(mappings, opts)
end

local lsp_g_keymaps = function(bufnr)
	local opts = {
		mode = "n",
		prefix = "g",
		buffer = bufnr,
	}
	local mappings = {
		D = { "<cmd>lua vim.lsp.buf.declaration()<CR>", "Declaration" },
		d = { "<cmd>lua vim.lsp.buf.definition()<CR>", "Definition" },
		I = { "<cmd>lua vim.lsp.buf.implementation()<CR>", "Implementation" },
		r = { "<cmd>lua vim.lsp.buf.references()<CR>", "References" },
		e = { ":lua require'popui.diagnostics-navigator'()<CR>", "Diagnostics" },
	}
	wk.register(mappings, opts)
end

local lsp_l_keymaps = function(bufnr)
	local opts = {
		mode = "n",
		prefix = "<leader>",
		buffer = bufnr,
	}
	local mappings = {
		k = { "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>", "which_key_ignore" },
		j = { "<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>", "which_key_ignore" },
		["<Space>"] = { "<cmd>Trouble document_diagnostics<CR>", "which_key_ignore" },

		l = {
			name = "Lsp Actions",
			s = { "<cmd>Telescope luasnip<CR>", "Snippets" },
			f = { "<cmd>lua vim.lsp.buf.format({async = true})<cr>", "Formatting" },
			k = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Signature Help" },
			r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
			q = { "<cmd>lua vim.diagnostic.setloclist()<CR>", "Daignostic List" },
			a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
		},
	}
	wk.register(mappings, opts)
end

local rust_maps = function(bufnr)
	local opts = {
		mode = "n", -- NORMAL mode
		prefix = "<leader>",
		buffer = bufnr, -- Global mappings. Specify a buffer number for buffer local mappings
		silent = true, -- use `silent` when creating keymaps
		noremap = true, -- use `noremap` when creating keymaps
		nowait = true, -- use `nowait` when creating keymaps
	}

	local mappings = {
		K = { ":RustHoverActions<CR>", "Hover Actions" },
		p = {
			name = "Rust",
			t = { "<cmd>RustToggleInlayHints<Cr>", "Toggle Hints" },
			r = { "<cmd>RustRunnables<Cr>", "Runnables" },
			m = { "<cmd>RustExpandMacro<Cr>", "Expand Macro" },
			c = { "<cmd>RustOpenCargo<Cr>", "Open Cargo" },
			p = { "<cmd>RustParentModule<Cr>", "Parent Module" },
			-- j = { "<cmd>RustJoinLines<Cr>", "Join Lines" },
			-- s = { "<cmd>RustStartStandaloneServerForBuffer<Cr>", "Start Server Buf" },
			d = { "<cmd>RustDebuggables<Cr>", "Debuggables" },
			v = { "<cmd>RustViewCrateGraph<Cr>", "View Crate Graph" },
			R = {
				"<cmd>lua require('rust-tools/workspace_refresh')._reload_workspace_from_cargo_toml()<Cr>",
				"Reload Workspace",
			},
			S = { "<cmd>RustSSR<Cr>", "SSR" },
			o = { "<cmd>RustOpenExternalDocs<Cr>", "Open External Docs" },
			-- h = { "<cmd>RustSetInlayHints<Cr>", "Enable Hints" },
			-- H = { "<cmd>RustDisableInlayHints<Cr>", "Disable Hints" },
			-- a = { "<cmd>RustHoverActions<Cr>", "Hover Actions" },
			-- a = { "<cmd>RustHoverRange<Cr>", "Hover Range" },
			-- j = { "<cmd>RustMoveItemDown<Cr>", "Move Item Down" },
			-- k = { "<cmd>RustMoveItemUp<Cr>", "Move Item Up" },
		},
	}

	wk.register(mappings, opts)
end

local go_keymaps = function(bufnr)
	local opts = {
		mode = "n",
		prefix = "<leader>",
		buffer = bufnr,
	}
	local mappings = {
		K = { "<cmd>lua vim.lsp.buf.hover()<CR>", "Hover Docs" },
		p = {
			name = "Go",
			r = { ":GoRun<CR>", "Go Run" },
			d = { ":GoDebug<CR>", "Go Debug" },
		},
	}
	wk.register(mappings, opts)
end

local lsp_doc_mapping = function(bufnr)
	local opts = {
		mode = "n",
		prefix = "",
		buffer = bufnr,
	}
	local mappings = {
		K = { "<cmd>lua vim.lsp.buf.hover()<CR>", "Hover Docs" },
	}
	wk.register(mappings, opts)
end

M.flutter_maps = function(bufnr)
	local opts = {
		mode = "n",
		prefix = "<leader>",
		buffer = bufnr,
	}
	local mappings = {
		p = {
			name = "Flutter",
			R = { "<cmd>FlutterRun<CR>", "Run" },
			d = { "<cmd>FlutterDevices<CR>", "Devices" },
			e = { "<cmd>FlutterEmulators<CR>", "Emulators" },
			["<C-R>"] = { "<cmd>FlutterReload<CR>", "Reload" },
			r = { "<cmd>FlutterRestart<CR>", "Restart" },
			q = { "<cmd>FlutterQuit<CR>", "Quit" },
			D = { "<cmd>FlutterDetach<CR>", "Detach" },
			o = { "<cmd>FlutterOutlineToggle<CR>", "Outline Toggle" },
			t = { "<cmd>FlutterDevTools<CR>", "Dev Tools" },
			y = { "<cmd>FlutterCopyProfileUrl<CR>", "Copy Profile URL" },
			l = { "<cmd>FlutterLspRestart<CR>", "LSP Restart" },
			a = { "<cmd>Telescope flutter commands<CR>", "Flutter Tools" },
		},
	}

	wk.register(mappings, opts)
end

--@desc The lsp function allows the LSP handler to access the keymapping fucntions by client.name
M.attach = function(client, bufnr)
	local servers = {
		rust_analyzer = rust_maps,
		gopls = go_keymaps,
		l = lsp_l_keymaps,
		g = lsp_g_keymaps,
		docs = lsp_doc_mapping,
	}

	servers.g(bufnr)
	servers.l(bufnr)

	if client == "dartls" then
		servers.dartls(bufnr)
		servers.docs(bufnr)
		return
	end
	if client == "rust_analyzer" then
		servers.rust_analyzer(bufnr)
		return
	end
	if client == "gopls" then
		servers.gopls(bufnr)
		return
	end
	servers.docs(bufnr)
end

-- Function Calls
plug_maps()
standard_maps()
bracket_maps()

return M
