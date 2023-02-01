local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	max_jobs = 10,
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- Install your plugins here
return packer.startup(function(use)
	-- Dependencies
	use({ "wbthomason/packer.nvim" })
	use({ "nvim-lua/plenary.nvim" })
	use({ "moll/vim-bbye" })
	use({ "lewis6991/impatient.nvim" })
	use({ "kkharji/sqlite.lua" })
	use({ "stevearc/dressing.nvim" })
	use({
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v2.x",
		requires = {
			"nvim-lua/plenary.nvim",
			"kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
	})

	-- UI --
	-- use({ "ray-x/guihua.lua" })
	use({ "lukas-reineke/headlines.nvim" })
	use({ "karb94/neoscroll.nvim" })
	-- PopOvers/PopUps
	use({ "folke/trouble.nvim" })
	-- Statusline/Tabline
	use({ "nanozuki/tabby.nvim" })
	use({ "feline-nvim/feline.nvim" })
	-- Overlays
	use({ "lukas-reineke/indent-blankline.nvim" })
	use({ "goolord/alpha-nvim" })
	use({ "kevinhwang91/nvim-bqf", ft = "qf" })
	use({
		"junegunn/fzf",
		run = function()
			vim.fn["fzf#install"]()
		end,
	})
	use({ "j-hui/fidget.nvim" })
	use({
		"s1n7ax/nvim-window-picker",
		tag = "v1.*",
	})

	--Icons
	use({ "kyazdani42/nvim-web-devicons" })
	-- Colorschemes
	use({ "folke/tokyonight.nvim" })
	use({ "olivercederborg/poimandres.nvim" })
	use({ "rebelot/kanagawa.nvim" })
	use({ "lunarvim/darkplus.nvim" })
	use({ "EdenEast/nightfox.nvim" })
	use({ "kvrohit/rasmus.nvim" })
	use({ "marko-cerovac/material.nvim" })
	use({ "frenzyexists/aquarium-vim" })
	use({ "olimorris/onedarkpro.nvim" })
	use({ "savq/melange" })
	use({ "kvrohit/mellow.nvim" })
	use({ "catppuccin/nvim", as = "catppuccin" })
	use({ "adisen99/apprentice.nvim", requires = "rktjmp/lush.nvim" })
	use({ "Shatur/neovim-ayu" })
	use({ "NTBBloodbath/doom-one.nvim" })
	use({ "Yazeed1s/minimal.nvim" })
	use({ "kvrohit/substrata.nvim" })
	use({ "rose-pine/neovim", as = "rose-pine" })
	use({ "shaunsingh/nord.nvim" })
	use({ "rockyzhang24/arctic.nvim", requires = "rktjmp/lush.nvim" })
	use({ "sainnhe/edge" })
	use({ "fenetikm/falcon" })
	use({ "kaiuri/nvim-juliana" })
	use({ "mcchrish/zenbones.nvim", requires = "rktjmp/lush.nvim" })
	use({ "Yazeed1s/oh-lucy.nvim" })
	use({ "ramojus/mellifluous.nvim", requires = "rktjmp/lush.nvim" })
	use({ "rafamadriz/neon" })
	use({ "bluz71/vim-nightfly-colors" })

	-- Editing --
	use({ "ggandor/leap.nvim" })
	use({
		"kylechui/nvim-surround",
		config = function()
			require("nvim-surround").setup()
		end,
	})
	use({ "ahmedkhalf/project.nvim" })
	use({ "akinsho/toggleterm.nvim" })

	-- Mappings
	use({ "folke/which-key.nvim" })
	use({ "mg979/vim-visual-multi" })
	-- Notes/Organization
	-- use({ "nvim-neorg/neorg" })
	-- use({ "max397574/neorg-kanban" })
	-- Navigation/Browsing
	use({ "simrat39/symbols-outline.nvim" })
	use({ "numToStr/Comment.nvim" })
	use({ "abecodes/tabout.nvim" })
	use({ "ThePrimeagen/harpoon" })
	-- Telescope
	use({ "nvim-telescope/telescope.nvim", tag = "0.1.0", requires = { { "nvim-lua/plenary.nvim" } } })
	use({ "nvim-telescope/telescope-ui-select.nvim" })
	use({ "nvim-telescope/telescope-project.nvim" })
	use({ "nvim-telescope/telescope-file-browser.nvim" })
	use({ "benfowler/telescope-luasnip.nvim" })

	-- Development --
	-- Auto-Completions

	-- cmp
	use({ "hrsh7th/nvim-cmp" })
	use({ "hrsh7th/cmp-buffer" })
	use({ "hrsh7th/cmp-path" })
	use({ "saadparwaiz1/cmp_luasnip" })
	use({ "hrsh7th/cmp-nvim-lsp" })
	use({ "hrsh7th/cmp-nvim-lua" })
	-- use({ "hrsh7th/cmp-nvim-lsp-signature-help" })
	use({ "KadoBOT/cmp-plugins" })
	-- Snippets
	use({ "L3MON4D3/LuaSnip" })
	use({ "rafamadriz/friendly-snippets" })
	-- LSP
	use({
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
		"jayp0521/mason-null-ls.nvim",
		"jose-elias-alvarez/null-ls.nvim",
		"ThePrimeagen/refactoring.nvim",
	})
	use({ "RRethy/vim-illuminate" })
	-- Diagnostics
	-- JSON
	use({ "b0o/SchemaStore.nvim" })
	-- Rust
	use({ "simrat39/rust-tools.nvim" })
	use({ "saecki/crates.nvim" })
	-- Go
	use({ "ray-x/go.nvim" })
	-- Flutter
	use({ "akinsho/flutter-tools.nvim" })
	-- SQL
	use({ "nanotee/sqls.nvim" })
	-- Neovim LuaDev
	use({ "folke/neodev.nvim" })
	-- TypeScript
	use({
		"jose-elias-alvarez/typescript.nvim",
	})
	-- Treesitter
	use({ "nvim-treesitter/nvim-treesitter" })
	use({ "nvim-treesitter/nvim-treesitter-context" })
	use({ "JoosepAlviste/nvim-ts-context-commentstring" })
	use({ "windwp/nvim-ts-autotag" })
	use({ "windwp/nvim-autopairs" })
	use({ "David-Kunz/markid" })
	-- Git
	use({ "lewis6991/gitsigns.nvim" })
	-- DAP
	use({ "mfussenegger/nvim-dap" })
	use({ "rcarriga/nvim-dap-ui" })
	use({ "jbyuki/one-small-step-for-vimkind" })
	use({ "theHamsta/nvim-dap-virtual-text" })

	use({ "lvimuser/lsp-inlayhints.nvim" })
	use({ "ray-x/lsp_signature.nvim" })

	use({
		"SmiteshP/nvim-navic",
		requires = "neovim/nvim-lspconfig",
	})

	use({
		"Djancyp/outline",
		config = function()
			require("outline").setup()
		end,
	})

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
