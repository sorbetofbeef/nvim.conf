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
    { import = "user.lsp.lsp-ui" },
    { "nvim-lua/plenary.nvim" },
    { "moll/vim-bbye" },
    { "lewis6991/impatient.nvim" },
    { "kkharji/sqlite.lua" },
    -- { "stevearc/dressing.nvim", dependencies = { "MunifTanjim/nui.nvim" }, event = "VeryLazy" },
    -- UI --
    -- { "ray-x/guihua.lua", build = "cd lua/fzy && make", config = true },
    { "lukas-reineke/headlines.nvim" },
    { "karb94/neoscroll.nvim" },
    -- PopOvers/PopUps
    { "folke/trouble.nvim" },
    -- Statusline/Tabline
    { "nanozuki/tabby.nvim" },
    { "feline-nvim/feline.nvim" },
    -- Overlays
    { "lukas-reineke/indent-blankline.nvim" },
    { "kevinhwang91/nvim-bqf",              ft = "qf" },
    {
      "junegunn/fzf",
      build = function()
        vim.fn["fzf#install"]()
      end,
    },
    { "j-hui/fidget.nvim" },

    --Icons
    { "nvim-tree/nvim-web-devicons" },
    -- Colorschemes
    { "psliwka/termcolors.nvim" },
    -- { "mhartington/oceanic-next", lazy = true, priority = 1000 },
    -- { "embark-theme/vim", name = "embark", lazy = true, priority = 1000 },
    -- { "folke/tokyonight.nvim", lazy = true, priority = 1000 },
    -- { "olivercederborg/poimandres.nvim", lazy = true, priority = 1000 },
    -- { "rebelot/kanagawa.nvim", lazy = true, priority = 1000 },
    -- { "lunarvim/darkplus.nvim", lazy = true, priority = 1000 },
    -- { "EdenEast/nightfox.nvim", lazy = true, priority = 1000 },
    -- { "kvrohit/rasmus.nvim", lazy = true, priority = 1000 },
    -- { "marko-cerovac/material.nvim", lazy = true, priority = 1000 },
    -- { "frenzyexists/aquarium-vim", lazy = false, priority = 1000 },
    -- { "olimorris/onedarkpro.nvim", lazy = true, priority = 1000 },
    -- { "savq/melange", lazy = true, priority = 1000 },
    -- { "kvrohit/mellow.nvim", lazy = true, priority = 1000 },
    { "catppuccin/nvim",              name = "catppuccin", lazy = true, priority = 1000 },
    -- { "adisen99/apprentice.nvim", dependencies = "rktjmp/lush.nvim", lazy = true, priority = 1000 },
    -- { "Shatur/neovim-ayu", lazy = true, priority = 1000 },
    -- { "NTBBloodbath/doom-one.nvim", lazy = true, priority = 1000 },
    -- { "Yazeed1s/minimal.nvim", lazy = true, priority = 1000 },
    -- { "kvrohit/substrata.nvim", lazy = true, priority = 1000 },
    -- { "rose-pine/neovim", name = "rose-pine", lazy = true, priority = 1000 },
    -- { "shaunsingh/nord.nvim", lazy = true, priority = 1000 },
    -- { "rockyzhang24/arctic.nvim", dependencies = "rktjmp/lush.nvim", lazy = true, priority = 1000 },
    -- { "sainnhe/edge", lazy = true, priority = 1000 },
    -- { "fenetikm/falcon", lazy = true, priority = 1000 },
    -- { "kaiuri/nvim-juliana", lazy = true, priority = 1000 },
    -- { "mcchrish/zenbones.nvim", dependencies = "rktjmp/lush.nvim", lazy = true, priority = 1000 },
    -- { "Yazeed1s/oh-lucy.nvim", lazy = true, priority = 1000 },
    -- { "ramojus/mellifluous.nvim", dependencies = "rktjmp/lush.nvim", lazy = true, priority = 1000 },
    -- { "rafamadriz/neon", lazy = true, priority = 1000 },
    -- { "bluz71/vim-nightfly-colors", lazy = true, priority = 1000 },
    -- { 'nyngwang/nvimgelion', lazy = true, priority = 1000},
    -- {
    -- 	"gbprod/nord.nvim",
    -- 	lazy = false,
    -- 	priority = 1000,
    -- 	opts = {
    -- 		-- your configuration comes here
    -- 		transparent = false, -- Enable this to disable setting the background color
    -- 		terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
    -- 		diff = { mode = "bg" }, -- enables/disables colorful backgrounds when used in diff mode. values : [bg|fg]
    -- 		borders = true, -- Enable the border between verticaly split windows visible
    -- 		errors = { mode = "bg" }, -- Display mode for errors and diagnostics
    -- 		styles = {
    -- 			comments = { italic = true },
    -- 			keywords = { bold = true },
    -- 			functions = { italic = true, bold = true },
    -- 			variables = { bold = true },
    -- 		},
    -- 		-- colorblind mode
    -- 		colorblind = {
    -- 			enable = false,
    -- 			preserve_background = false,
    -- 			severity = {
    -- 				protan = 0.0,
    -- 				deutan = 0.0,
    -- 				tritan = 0.0,
    -- 			},
    -- 		},
    -- 	},
    -- 	config = function()
    -- 		vim.cmd("colorscheme nord")
    -- 	end,
    -- },

    -- Editing --
    { "ggandor/leap.nvim" },
    { "ahmedkhalf/project.nvim" },
    { "akinsho/toggleterm.nvim" },

    -- Mappings
    { "mg979/vim-visual-multi" },
    -- Notes/Organization
    { "nvim-neorg/neorg" },
    -- Navigation/Browsing
    { "simrat39/symbols-outline.nvim" },
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
    { "williamboman/mason.nvim" },
    { "williamboman/mason-lspconfig.nvim" },
    { "neovim/nvim-lspconfig" },
    { "jayp0521/mason-null-ls.nvim" },
    { "jose-elias-alvarez/null-ls.nvim" },
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
    { "David-Kunz/markid" },
    -- Git
    { "lewis6991/gitsigns.nvim" },
    -- DAP
    { "jbyuki/one-small-step-for-vimkind" },
    { "theHamsta/nvim-dap-virtual-text" },
    {
      "SmiteshP/nvim-navic",
      dependencies = "neovim/nvim-lspconfig",
    },

    { "Djancyp/outline", config = true },
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
