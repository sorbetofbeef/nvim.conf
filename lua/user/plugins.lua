-- Automatically install lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  -- bootstrap lazy.nvim
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable",
    lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)
-- Shorten function name

--Remap space as leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("lazy").setup({
	spec = {
		{ import = "user.plugins.modules" },
		-- { import = "user.lsp.lsp-ui" },
		{ "nvim-lua/plenary.nvim" },
		{ "moll/vim-bbye" },
		{ "kkharji/sqlite.lua" },
		-- UI --
		{ "lukas-reineke/headlines.nvim" },
		{ "karb94/neoscroll.nvim" },
		-- PopOvers/PopUps
		{ "folke/trouble.nvim" },
		-- Statusline/Tabline
		{ "nanozuki/tabby.nvim" },
		{ "feline-nvim/feline.nvim" },
		-- Overlays
		{ "lukas-reineke/indent-blankline.nvim" },
		{
			"junegunn/fzf",
			build = function()
				vim.fn["fzf#install"]()
			end,
		},
		--Icons
		{ "nvim-tree/nvim-web-devicons" },
		-- Colorschemes
		{ "psliwka/termcolors.nvim" },
		-- Editing --
		{ "ggandor/leap.nvim" },
		{ "ahmedkhalf/project.nvim" },
		-- Mappings
		{ "mg979/vim-visual-multi" },
		-- Notes/Organization
		{ "nvim-neorg/neorg" },
		-- Navigation/Browsing
		{ "simrat39/symbols-outline.nvim" },
		{ "abecodes/tabout.nvim" },
		-- Telescope
		{
			"nvim-telescope/telescope.nvim",
			version = "0.1.0",
			dependencies = { "nvim-lua/plenary.nvim" },
		},
		{ "nvim-telescope/telescope-ui-select.nvim" },
		{ "nvim-telescope/telescope-project.nvim" },
		{ "benfowler/telescope-luasnip.nvim" },
		-- Development --
		-- JSON
		{ "b0o/Schemastore.nvim" },
		-- Rust
		{ "simrat39/rust-tools.nvim" },
		{ "saecki/crates.nvim" },
		-- Go
		{ "ray-x/go.nvim" },
		-- Flutter
		{ "akinsho/flutter-tools.nvim" },
		-- Neovim LuaDev
		{ "folke/neodev.nvim" },
		-- TypeScript
		{ "windwp/nvim-ts-autotag" },
		{ "David-Kunz/markid" },
		-- Git
		{ "lewis6991/gitsigns.nvim" },
		-- DAP
		{ "jbyuki/one-small-step-for-vimkind" },
		{ "theHamsta/nvim-dap-virtual-text" },
	},
	defaults = {
		-- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
		-- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
		lazy = false,
		-- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
		-- have outdated relenamees, which may break your Neovim install.
		version = false, -- always use the latest git commit
		-- version = "*", -- try installing the latest stable version for plugins that support semver
	},
	checker = { enabled = true, notify = false }, -- automatically check for plugin updates
	performance = {
		rtp = {
			-- disable some rtp plugins
			disabled_plugins = {
				"gzip",
				"matchit",
				"matchparen",
				"netrwPlugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
})
