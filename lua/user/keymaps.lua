local status_ok, wk = pcall(require, "which-key")

if not status_ok then
	return
end

-- Exported functions
local M = {}

-- Shorten function name
local keymap = vim.keymap.set

--Remap space as leader key

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

	-- Split handling
	keymap("n", "<leader>sw", "<C-W>p", { desc = "Other window" })
	keymap("n", "<leader>sS", "<C-W>s", { desc = "Split window below" })
	keymap("n", "<leader>ss", "<C-W>v", { desc = "Split window right" })

	-- Resize with arrows
	keymap("n", "<C-Up>", "<cmd>resize -2<CR>", opts)
	keymap("n", "<C-Down>", "<cmd>resize +2<CR>", opts)
	keymap("n", "<C-Left>", "<cmd>vertical resize -2<CR>", opts)
	keymap("n", "<C-Right>", "<cmd>vertical resize +2<CR>", opts)

	keymap("i", "<C-k>", "<Up>", opts)
	keymap("i", "<C-j>", "<Down>", opts)
	keymap("i", "<C-h>", "<Left>", opts)
	keymap("i", "<C-l>", "<Right>", opts)

	-- Buffers --
	keymap("n", "L", ":bnext<CR>", opts)
	keymap("n", "H", ":bprevious<CR>", opts)

	-- Movement --
	-- Sane movement defaults that works on long wrapped lines
	local expr = { expr = true, noremap = false, silent = false }
	keymap("n", "j", "(v:count ? 'j' : 'gj')", expr)
	keymap("n", "k", "(v:count ? 'k' : 'gk')", expr)
	keymap("i", "<C-h>", "<Left>", expr)
	keymap("i", "<C-j>", "<Down>", expr)
	keymap("i", "<C-k>", "<Up>", expr)
	keymap("i", "<C-l>", "<Right>", expr)

	--[[ keymap("n", "<c-d>", "<c-d>zz", opts)
	keymap("n", "<c-u>", "<c-u>zz", opts)

	keymap("n", "<c-f>", "<c-f>zz", opts)
	keymap("n", "<c-b>", "<c-b>zz", opts) ]]
	keymap("n", "x", '"_x', opts) -- delete char without yank
	keymap("x", "x", '"_x', opts) -- delete visual selection without yank

	-- paste in visual mode and keep available
	keymap("v", "p", [['pgv"'.v:register.'y`>']], expr)
	keymap("v", "P", [['Pgv"'.v:register.'y`>']], expr)
	-- select last inserted text
	keymap("n", "gV", [['`[' . strpart(getregtype(), 0, 1) . '`]']], expr)

	keymap("i", "jk", "<ESC>", opts)
	keymap("v", "jk", "<ESC>", opts)

	keymap("v", "<", "<gv", opts)
	keymap("v", ">", ">gv", opts)
	-- tabs
	keymap("n", "<tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
	keymap("n", "<tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
	keymap("n", "<tab>t", "<cmd>tabnew<cr>", { desc = "New Tab" })
	keymap("n", "<tab>j", "<cmd>tabnext<cr>", { desc = "Next Tab" })
	keymap("n", "<tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })
	keymap("n", "<tab>k", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })
end

local bracket_maps = function()
	local opts = {
		mode = "n",
	}

	local mappings = {
		["["] = {
			name = "< Harpoon",
			h = { "<cmd>lua require('harpoon.ui').nav_prev()<cr>", "Harpoon Backward" },
		},
		["]"] = {
			name = "Harpoon >",
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
		-- b = { "<cmd>Neotree toggle buffers<CR>", "Buffers" },
		-- ["<leader>"] = { '[[<c-^>"zz]]', "Last buffer" },
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
		m = { "<cmd>lua require('dropbar.api').pick()<CR>", "Dropbar Jump" },
		-- Symbol Outline
		o = { "<cmd>SymbolsOutline<CR>", "Symbols Panel" },
		-- DAP
		d = {
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
		s = { name = "Split" },
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
		i = { "<cmd>lua vim.lsp.buf.implementation()<CR>", "Implementation" },
		r = { "<cmd>lua vim.lsp.buf.references()<CR>", "References" },
		e = { "<cmd>Trouble document_diagnostics<CR>", "Diagnostics" },
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
		k = { "<cmd>LspUI diagnostic prev<cr>", "which_key_ignore" },
		j = { "<cmd>LspUI diagnostic next<cr>", "which_key_ignore" },
		["<Space>"] = { "<cmd>Trouble workspace_diagnostics<CR>", "which_key_ignore" },
		l = {
			name = "Lsp Actions",
			w = {
				name = "Workspace Actions",
				a = { vim.lsp.buf.add_workspace_folder, "Add Workspace Folder" },
				r = { vim.lsp.buf.remove_workspace_folder, "Remove Workspace Folder" },
				l = {
					function()
						print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
					end,
					"List Workspace Folders",
				},
			},
			s = { "<cmd>Telescope luasnip<CR>", "Snippets" },
			f = { "<cmd>lua vim.lsp.buf.format({async = true})<cr>", "Formatting" },
			k = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Signature Help" },
			-- r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
			r = { "<cmd>LspUI rename<cr>", "Rename" },
			-- q = { "<cmd>lua vim.diagnostic.setloclist()<CR>", "Diagnostic List" },
			-- a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
			a = { "<cmd>LspUI code_action<cr>", "Code Action" },
		},
	}
	wk.register(mappings, opts)
end
M.sqls_maps = function(bufnr)
	local opts = {
		mode = "n",
		prefix = "<leader>",
		buffer = bufnr, -- Global mappings. Specify a buffer number for buffer local mappings
		silent = true, -- use `silent` when creating keymaps
		noremap = true, -- use `noremap` when creating keymaps
		nowait = true, -- use `nowait` when creating keymaps
	}

	local mappings = {
		D = {
			name = "Databases Options",
			p = { "<cmd>DB postgresql://me:2319@127.0.0.1:5432/cocktails<CR>", desc = "PostgreSQL Connection" },
			d = { ":SqlsShowDatabases<CR>", desc = "Show Databases" },
			S = { ":SqlsShowSchemas<CR>", desc = "Show Schemas" },
			c = { ":SqlsShowConnections<CR>", desc = "Show Connections" },
			D = { ":SqlsSwitchDatabase<CR>", desc = "Switch Databases" },
			C = { ":SqlsSwitchConnections<CR>", desc = "Switch Connections" },
		},
	}

	wk.register(mappings, opts)
end

M.rust_maps = function(bufnr)
	local opts = {
		mode = "n", -- NORMAL mode
		prefix = "<leader>l",
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

M.go_keymaps = function(bufnr)
	local normal_mode = { mode = "n" }
	local visual_mode = { mode = "v" }

	local opts = {
		prefix = "<leader>l",
		buffer = bufnr,
		noremap = true,
		nowait = true,
		silent = true,
	}
	local normal_opts = vim.tbl_deep_extend("force", normal_mode, opts)
	local visual_opts = vim.tbl_deep_extend("force", visual_mode, opts)

	local normal_mappings = {
		p = {
			name = "Go",
			a = { "<cmd>GoCodeAction<cr>", "Code Action" },
			e = { "<cmd>GoIfErr<cr>", "Add if..err" },
			h = {
				name = "Helper",
				a = { "<cmd>GoAddTag<cr>", "Add Tags" },
				r = { "<cmd>GoRMTag<cr>", "Remove Tags" },
				c = { "<cmd>GoCoverage<cr>", "Test Coverage" },
				g = { "<cmd>lua require('go.comment').gen()<cr>", "Generate Comment" },
				v = { "<cmd>GoVet<cr>", "Go vet" },
				t = { "<cmd>GoModTidy<cr>", "Go Mod Tidy" },
				i = { "<cmd>GoModInit<cr>", "Go Mod Init" },
			},
			i = { "<cmd>GoToggleInlay<cr>", "Toggle Inlay" },
			l = { "<cmd>GoLint<cr>", "Run Linter" },
			o = { "<cmd>GoPkgOutline<cr>", "Outline" },
			r = { "<cmd>GoRun<cr>", "Run" },
			s = { "<cmd>GoFillStruct<cr>", "Autofill Struct" },
			t = {
				name = "Tests",
				r = { "<cmd>GoTest<cr>", "Run Tests" },
				a = { "<cmd>GoAlt!<cr>", "Open Alt" },
				s = { "<cmd>GoAltS!<cr>", "Open Split Alt" },
				v = { "<cmd>GoAltV!<cr>", "Open VSplit Alt" },
				u = { "<cmd>GoTestFunc<cr>", "Run Func Test" },
				f = { "<cmd>GoTestFile<cr>", "Run Tests" },
			},
			x = {
				name = "Code Lens",
				l = { "<cmd>GoCodeLenAct<cr>", "Toggle Lens" },
				a = { "<cmd>GoCodeAction<cr>", "Code Action" },
			},
		},
	}
	local visual_mappings = {
		p = {
			-- name = "Coding",
			j = { "<cmd>'<,'>GoJson2Struct<cr>", "Json to struct" },
		},
	}
	wk.register(normal_mappings, normal_opts)
	wk.register(visual_mappings, visual_opts)
end

local lsp_doc_mapping = function(bufnr)
	local opts = {
		mode = "n",
		prefix = "",
		buffer = bufnr,
	}
	local mappings = {
		K = { "<cmd>LspUI hover<CR>", "Hover Docs" },
	}
	wk.register(mappings, opts)
end

M.flutter_maps = function(bufnr)
	local opts = {
		mode = "n",
		prefix = "<leader>l",
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

-- TypeScript
M.ts_maps = function(bufnr)
	local opts = {
		mode = "n",
		prefix = "<leader>l",
		buffer = bufnr,
	}

	local mappings = {
		p = {
			name = "TypeScript",
			R = { "", "which_key_ignore" },
			d = { "<cmd>TypescriptRemoveUnused<cr>", "Remove Unused Imports" },
			e = { "<cmd>TypescriptFixAll<cr>", "Fix Some" },
			["<C-R>"] = { "", "which_key_ignore" },
			r = { "<cmd>TypescriptRenameFile<cr>", "Rename File" },
			q = { "", "which_key_ignore" },
			D = { "", "which_key_ignore" },
			o = { "<cmd>TypescriptOrganizeImports<cr>", "Organize Imports" },
			t = { "<cmd>TypescriptGoToSourceDefinition(winnr, opts)<cr>", "Go to Source" },
			y = { "", "which_key_ignore" },
			l = { "", "which_key_ignore" },
			a = { "<cmd>TypescriptAddMissingImports<cr>", "Add Missing Imports" },
		},
	}

	wk.register(mappings, opts)
end

--@desc The lsp function allows the LSP handler to access the keymapping functions by client.name
M.attach = function(_, bufnr)
	local servers = {
		l = lsp_l_keymaps,
		g = lsp_g_keymaps,
		docs = lsp_doc_mapping,
	}

	servers.g(bufnr)
	servers.l(bufnr)
	servers.docs(bufnr)
end

-- Function Calls
plug_maps()
standard_maps()
bracket_maps()

return M
