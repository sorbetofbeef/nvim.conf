local status_ok, wk = pcall(require, "which-key")
if not status_ok then
	return
end

-- Shorten function name
local keymap = vim.keymap.set

--Remap space as leader key
keymap("", "<Space>", "<Nop>", { silent = true })
vim.g.mapleader = " "

local function standard_maps ()
  local opts = {
    silent = true,
    noremap = true
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

  -- Navigate buffers
  keymap("n", "<S-l>", ":bnext<CR>", opts)
  keymap("n", "<S-h>", ":bprevious<CR>", opts)

  -- Better paste
  -- keymap("n", "p", "_dP", opts)
  keymap("i", "jk", "<ESC>", opts)
  keymap("v", "<", "<gv", opts)
  keymap("v", ">", ">gv", opts)
end

local plug_maps = function()
	local opts = {
		mode = "n",
		prefix = "<leader>",
	}

	local mappings = {
		-- Plugins --
		-- NvimTree
		e = { "<cmd>NvimTreeToggle<CR>", "NvimTree" },

		-- Telescope
		f = {
			name = "Telescope",
			f = { "<cmd>Telescope find_files<CR>", "Find File" },
			t = { "<cmd>Telescope live_grep<CR>", "Find Text" },
			p = { "<cmd>Telescope projects<CR>", "Find Projects" },
			b = { "<cmd>Telescope buffers<CR>", "Find Buffers" },
			k = { "<cmd>Telescope keymaps<CR>", "Find Keymaps" },
		},

		-- Git
		g = { "<cmd>lua _LAZYGIT_TOGGLE()<CR>", "LazyGit" },

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
		["h"] = { "<cmd>nohlsearch<CR>", "which_key_ignore" },

		-- Close buffers
		["C"] = { "<cmd>Bdelete!<CR>", "which_key_ignore" },
		["c"] = { "<cmd>Bdelete<CR>", "which_key_ignore" },
		["Q"] = { "<cmd>quit!<CR>", "which_key_ignore" },
		["q"] = { "<cmd>quit<CR>", "which_key_ignore" },
		["W"] = { "<cmd>wqa<CR>", "which_key_ignore" },
		["w"] = { "<cmd>wa<CR>", "which_key_ignore" },

		-- Comment
		-- c = { "<cmd>lua require('Comment.api').toggle_current_linewise()<CR>", "Comment Line", {opts = "g" } },
		-- b = { '<ESC><CMD>lua require("Comment.api").toggle_linewise_op(vim.fn.visualmode())<CR>', "Comment Block", { { opts = "g"}, { mode = "v" } } }
	}
	wk.register(mappings, opts)
end

plug_maps()
standard_maps()
