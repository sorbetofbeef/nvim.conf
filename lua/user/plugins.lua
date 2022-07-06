local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use { 'wbthomason/packer.nvim' }
  use { 'nvim-lua/plenary.nvim' }
  use { 'moll/vim-bbye' }
  use { 'lewis6991/impatient.nvim' }


-- UI --

  use {'hood/popui.nvim' }
  use {'RishabhRD/popfix' }
  use { 'goolord/alpha-nvim' }
  use { 'kyazdani42/nvim-web-devicons' }
  use { 'nanozuki/tabby.nvim' }
  use { 'feline-nvim/feline.nvim' }
  use { 'karb94/neoscroll.nvim' }
  use { 'lukas-reineke/indent-blankline.nvim' }

  -- Colorschemes
  use { 'folke/tokyonight.nvim' }
  use { 'lunarvim/darkplus.nvim' }
  use { 'ray-x/starry.nvim'}
  use { 'frenzyexists/aquarium-vim'}
  use { 'EdenEast/nightfox.nvim'}


-- Editing --
  use { 'windwp/nvim-ts-autotag' }
  use { 'numToStr/Comment.nvim' }
  use { 'windwp/nvim-autopairs' }
  use { 'kyazdani42/nvim-tree.lua' }
  use { 'ahmedkhalf/project.nvim' }
  use { 'akinsho/toggleterm.nvim' }
  -- Mappings
  use { 'folke/which-key.nvim' }
  use { 'mg979/vim-visual-multi' }


  -- Navigation/Browsing
  use { 'JoosepAlviste/nvim-ts-context-commentstring' }
  use { 'simrat39/symbols-outline.nvim' }
  use { 'christianchiarulli/nvim-gps', branch = 'text_hl' }


-- Development --

  -- cmp Plugins
  use { 'hrsh7th/nvim-cmp' }
  use { 'hrsh7th/cmp-buffer' }
  use { 'hrsh7th/cmp-path' }
  use { 'saadparwaiz1/cmp_luasnip' }
  use { 'hrsh7th/cmp-nvim-lsp' }
  use { 'hrsh7th/cmp-nvim-lua' }

  -- snippets
  use { 'L3MON4D3/LuaSnip' }
  use { 'rafamadriz/friendly-snippets' }

  -- LSP
  use { 'neovim/nvim-lspconfig' }
  use { 'williamboman/nvim-lsp-installer' }
  use { 'jose-elias-alvarez/null-ls.nvim' }
  use { 'RRethy/vim-illuminate' }

  -- Rust
  use { 'simrat39/rust-tools.nvim' }
  use { 'Saecki/crates.nvim'}

  -- SQL
  use { 'nanotee/sqls.nvim'}

  -- Telescope
  use { 'nvim-telescope/telescope.nvim' }

  -- Treesitter
  use { 'nvim-treesitter/nvim-treesitter' }

  -- Git
  use { 'lewis6991/gitsigns.nvim' }

  -- DAP
  use { 'mfussenegger/nvim-dap' }
  use { 'rcarriga/nvim-dap-ui' }
  use { 'ravenxrz/DAPInstall.nvim' }
  use { 'jbyuki/one-small-step-for-vimkind' }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
