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
	vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
	use({
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v2.x",
		requires = {
			"nvim-lua/plenary.nvim",
			"kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
	})

	-- use { 'beauwilliams/statusline.lua' }
	-- use({ "MunifTanjim/nui.nvim" })

	-- UI --
	-- PopOvers/PopUps
	--[[ use({ "karb94/neoscroll.nvim" }) ]]
	use({ "declancm/cinnamon.nvim" })
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
		config = function()
			require("window-picker").setup({
				include_current_win = true,
				use_winbar = "always", -- "always" | "never" | "smart"
				filter_rules = {
					-- filter using buffer options
					bo = {
						-- if the file type is one of following, the window will be ignored
						filetype = { "Outline", "NvimTree", "neo-tree", "notify" },

						-- if the buffer type is one of following, the window will be ignored
						buftype = { "terminal" },
					},

					-- filter using window options
					wo = {},

					-- if the file path contains one of following names, the window
					-- will be ignored
					file_path_contains = {},

					-- if the file name contains one of following names, the window will be
					-- ignored
					file_name_contains = {},
				},
			})
		end,
	})
	--Icons
	use({ "kyazdani42/nvim-web-devicons" })
	-- Colorschemes
	use({ "rebelot/kanagawa.nvim" })
	use({ "folke/tokyonight.nvim" })
	use({ "lunarvim/darkplus.nvim" })
	use({ "ray-x/starry.nvim" })
	use({ "EdenEast/nightfox.nvim" })
	use({ "kvrohit/rasmus.nvim" })
	use({ "marko-cerovac/material.nvim" })
	use({ "frenzyexists/aquarium-vim" })
	use({ "olimorris/onedarkpro.nvim" })
	use({ "savq/melange" })
	use({ "kvrohit/mellow.nvim" })
	use({ "catppuccin/nvim", as = "catppuccin" })
	use({ "adisen99/apprentice.nvim", requires = { "rktjmp/lush.nvim" } })
	use({ "Shatur/neovim-ayu" })
	use({ "olivercederborg/poimandres.nvim" })
	use({ "NTBBloodbath/doom-one.nvim" })
	use({ "lukas-reineke/headlines.nvim" })

	-- Editing --
	use({
		"kylechui/nvim-surround",
		config = function()
			require("nvim-surround").setup()
		end,
	})
	use({ "kyazdani42/nvim-tree.lua" })
	use({ "ahmedkhalf/project.nvim" })
	use({ "akinsho/toggleterm.nvim" })
	--[[ use({ "romgrk/nvim-treesitter-context",
    config = function()
    require("treesitter-context").setup{
        enable = true,
        throttle = true,
        max_lines = 0,
        patterns = {
        default = {
        'class',
        'function',
        'method',
        },
        },
      }
end,

  }) ]]
	-- Mappings
	use({ "folke/which-key.nvim" })
	use({ "mg979/vim-visual-multi" })
	-- Notes/Organization
	use({ "nvim-neorg/neorg" })
	use({ "max397574/neorg-kanban" })
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
	use({ "f3fora/cmp-spell" })
	-- coq
	--[[ use { 'ms-jpq/coq_nvim' }
  use { 'ms-jpq/coq.artifacts', branch = 'artifacts' }
  use { 'ms-jpq/coq.thirdparty', branch = '3p'} ]]
	-- Snippets
	use({ "L3MON4D3/LuaSnip" })
	use({ "rafamadriz/friendly-snippets" })
	-- LSP
	--[[ use({ "neovim/nvim-lspconfig" }) ]]
	use({ "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim", "neovim/nvim-lspconfig" })
	--[[ use({ "williamboman/nvim-lsp-installer" }) ]]
	use({ "RRethy/vim-illuminate" })
	-- Diagnostics
	-- null-ls
	use({ "jose-elias-alvarez/null-ls.nvim" })
	use({ "ThePrimeagen/refactoring.nvim" })
	--[[ use({
		"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
		config = function()
			require("lsp_lines").setup()
			vim.diagnostic.config({ virtual_lines = false })
		end,
	}) ]]
	-- JSON
	use({ "b0o/SchemaStore.nvim" })
	-- Rust
	use({ "simrat39/rust-tools.nvim" })
	use({ "saecki/crates.nvim" })
	-- Flutter
	use({ "akinsho/flutter-tools.nvim" })
	-- SQL
	use({ "nanotee/sqls.nvim" })
	-- Neovim LuaDev
	use({ "folke/neodev.nvim" })
	-- TypeScript
	use({ "jose-elias-alvarez/typescript.nvim" })
	-- Treesitter
	use({ "nvim-treesitter/nvim-treesitter" })
	use({ "nvim-treesitter/nvim-treesitter-context" })
	use({ "JoosepAlviste/nvim-ts-context-commentstring" })
	use({ "windwp/nvim-ts-autotag" })
	use({ "windwp/nvim-autopairs" })
	use("David-Kunz/markid")
	-- Git
	use({ "lewis6991/gitsigns.nvim" })
	-- DAP
	use({ "mfussenegger/nvim-dap" })
	use({ "rcarriga/nvim-dap-ui" })
	use({ "ravenxrz/DAPInstall.nvim" })
	use({ "jbyuki/one-small-step-for-vimkind" })

	use({ "lvimuser/lsp-inlayhints.nvim" })
	use({ "ray-x/lsp_signature.nvim" })

	use({
		"SmiteshP/nvim-navic",
		requires = "neovim/nvim-lspconfig",
	})

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
