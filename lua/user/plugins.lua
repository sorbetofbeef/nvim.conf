-- Automatically install lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  -- bootstrap lazy.nvim
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)
-- Shorten function name

--Remap space as leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

--Remap space as leader key
-- vim.g.mapleader = " "

-- Autocommand that reloads neovim whenever you save the plugins.lua file
-- vim.cmd([[
--   augroup packer_user_config
--     autocmd!
--     autocmd BufWritePost plugins.lua source <afile> | PackerSync
--   augroup end
-- ]])

-- Use a protected call so we don't error out on first use
--[[ local status_ok, laz = pcall(require, "lazy")
if not status_ok then
	return
end ]]

require("lazy").setup({
	spec = {
		{ "nvim-lua/plenary.nvim" },
		{ "moll/vim-bbye" },
		{ "lewis6991/impatient.nvim" },
		{ "kkharji/sqlite.lua" },
		{ "stevearc/dressing.nvim" },
		{
			"nvim-neo-tree/neo-tree.nvim",
			branch = "v2.x",
			dependencies = {
				"nvim-lua/plenary.nvim",
				"kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
				"MunifTanjim/nui.nvim",
			},
		},

		-- UI --
		-- { "ray-x/guihua.lua" },
		{ "lukas-reineke/headlines.nvim" },
		{ "karb94/neoscroll.nvim" },
		-- PopOvers/PopUps
		{ "folke/trouble.nvim" },
		-- Statusline/Tabline
		{ "nanozuki/tabby.nvim" },
		{ "feline-nvim/feline.nvim" },
		-- Overlays
		{ "lukas-reineke/indent-blankline.nvim" },
		-- { "goolord/alpha-nvim" },
		{ "kevinhwang91/nvim-bqf", ft = "qf" },
		{
			"junegunn/fzf",
			build = function()
				vim.fn["fzf#install"]()
			end,
		},
		{ "j-hui/fidget.nvim" },
		{
			"s1n7ax/nvim-window-picker",
			version = "v1.*",
		},

		--Icons
		{ "kyazdani42/nvim-web-devicons" },
		-- Colorschemes
		{ "folke/tokyonight.nvim", lazy = true },
		{ "olivercederborg/poimandres.nvim", lazy = true },
		{ "rebelot/kanagawa.nvim", lazy = true },
		{ "lunarvim/darkplus.nvim", lazy = true },
		{ "EdenEast/nightfox.nvim", lazy = true },
		{ "kvrohit/rasmus.nvim", lazy = true },
		{ "marko-cerovac/material.nvim", lazy = true },
		{ "frenzyexists/aquarium-vim", lazy = true },
		{ "olimorris/onedarkpro.nvim", lazy = true },
		{ "savq/melange", lazy = true },
		{ "kvrohit/mellow.nvim", lazy = true },
		{ "catppuccin/nvim", name = "catppuccin", lazy = true },
		{ "adisen99/apprentice.nvim", dependencies = "rktjmp/lush.nvim", lazy = true },
		{ "Shatur/neovim-ayu", lazy = true },
		{ "NTBBloodbath/doom-one.nvim", lazy = true },
		{ "Yazeed1s/minimal.nvim", lazy = true },
		{ "kvrohit/substrata.nvim", lazy = true },
		{ "rose-pine/neovim", name = "rose-pine", lazy = true },
		{ "shaunsingh/nord.nvim", lazy = true },
		{ "rockyzhang24/arctic.nvim", dependencies = "rktjmp/lush.nvim", lazy = true },
		{ "sainnhe/edge", lazy = true },
		{ "fenetikm/falcon", lazy = true },
		{ "kaiuri/nvim-juliana", lazy = true },
		{ "mcchrish/zenbones.nvim", dependencies = "rktjmp/lush.nvim", lazy = true },
		{ "Yazeed1s/oh-lucy.nvim", lazy = true },
		{ "ramojus/mellifluous.nvim", dependencies = "rktjmp/lush.nvim", lazy = true },
		{ "rafamadriz/neon", lazy = true },
		{ "bluz71/vim-nightfly-colors", lazy = true },

		-- Editing --
		{ "ggandor/leap.nvim" },
		{
			"kylechui/nvim-surround",
			config = true,
		},
		{ "ahmedkhalf/project.nvim" },
		{ "akinsho/toggleterm.nvim" },

		-- Mappings
		{ "folke/which-key.nvim" },
		{ "mg979/vim-visual-multi" },
		-- Notes/Organization
		{ "nvim-neorg/neorg", build = ":Neorg sync-parsers" },
		-- Navigation/Browsing
		{ "simrat39/symbols-outline.nvim" },
		{ "numToStr/Comment.nvim" },
		{ "abecodes/tabout.nvim" },
		{ "ThePrimeagen/harpoon" },
		-- Telescope
		{
			"nvim-telescope/telescope.nvim",
			version = "0.1.0",
			dependencies = { "nvim-lua/plenary.nvim" },
		},
		{ "nvim-telescope/telescope-ui-select.nvim" },
		{ "nvim-telescope/telescope-project.nvim" },
		{ "nvim-telescope/telescope-file-browser.nvim" },
		{ "benfowler/telescope-luasnip.nvim" },

		-- Development --
		-- Auto-Completions
		-- cmp
		{ "hrsh7th/nvim-cmp" },
		{ "hrsh7th/cmp-buffer" },
		{ "hrsh7th/cmp-path" },
		{ "saadparwaiz1/cmp_luasnip" },
		{ "hrsh7th/cmp-nvim-lsp" },
		{ "hrsh7th/cmp-nvim-lua" },
		{ "KadoBOT/cmp-plugins" },
		-- Snippets
		{ "L3MON4D3/Luasnip" },
		{ "rafamadriz/friendly-snippets" },
		-- LSP
		{
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"neovim/nvim-lspconfig",
			"jayp0521/mason-null-ls.nvim",
			"jose-elias-alvarez/null-ls.nvim",
			"ThePrimeagen/refactoring.nvim",
		},
		{ "RRethy/vim-illuminate" },
		-- Diagnostics
		-- JSON
		{ "b0o/Schemastore.nvim" },
		-- Rust
		{ "simrat39/rust-tools.nvim" },
		{ "saecki/crates.nvim" },
		-- Go
		{ "ray-x/go.nvim" },
		-- Flutter
		{ "akinsho/flutter-tools.nvim" },
		-- SQL
		{ "nanotee/sqls.nvim" },
		-- Neovim LuaDev
		{ "folke/neodev.nvim" },
		-- TypeScript
		{
			"jose-elias-alvarez/typescript.nvim",
		},
		-- Treesitter
		{ "nvim-treesitter/nvim-treesitter" },
		{ "nvim-treesitter/nvim-treesitter-context" },
		{ "JoosepAlviste/nvim-ts-context-commentstring" },
		{ "windwp/nvim-ts-autotag" },
		{ "windwp/nvim-autopairs" },
		{ "David-Kunz/markid" },
		-- Git
		{ "lewis6991/gitsigns.nvim" },
		-- DAP
		{ "mfussenegger/nvim-dap" },
		{ "rcarriga/nvim-dap-ui" },
		{ "jbyuki/one-small-step-for-vimkind" },
		{ "theHamsta/nvim-dap-virtual-text" },

		{ "lvimuser/lsp-inlayhints.nvim" },
		{ "ray-x/lsp_signature.nvim" },

		{
			"SmiteshP/nvim-navic",
			dependencies = "neovim/nvim-lspconfig",
		},

		{ "Djancyp/outline", config = true },
	},
	import = "user.alpha",
	defaults = {
		-- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
		-- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
		lazy = false,
		-- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
		-- have outdated relenamees, which may break your Neovim install.
		version = false, -- always use the latest git commit
		-- version = "*", -- try installing the latest stable version for plugins that support semver
	},
	checker = { enabled = true }, -- automatically check for plugin updates
	performance = {
		rtp = {
			-- disable some rtp plugins
			disabled_plugins = {
				"gzip",
				-- "matchit",
				-- "matchparen",
				-- "netrwPlugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
})
