-- Neovim Options --
vim.opt.backup = false -- creates a backup file
vim.opt.clipboard = "unnamedplus" -- allows neovim to access the system clipboard
vim.opt.cmdheight = 2 -- more space in the neovim command line for displaying messages
vim.opt.completeopt = { "menu", "menuone", "noselect" } -- mostly just for cmp
-- vim.opt.spellfile = "/Users/me/.config/nvim/spell/en.utf-8.add"
vim.opt.conceallevel = 0 -- so that `` is visible in markdown files
vim.opt.fileencoding = "utf-8" -- the encoding written to a file
vim.opt.hlsearch = true -- highlight all matches on previous search pattern
vim.opt.ignorecase = true -- ignore case in search patterns
vim.opt.mouse = "a" -- allow the mouse to be used in neovim
vim.opt.showmode = false -- we don't need to see things like -- INSERT -- anymore
vim.opt.showtabline = 2 -- always show tabs
vim.opt.laststatus = 3 -- always show tabs
vim.opt.smartcase = true -- smart case
vim.opt.smartindent = true -- make indenting smarter again
vim.opt.splitbelow = true -- force all horizontal splits to go below current window
vim.opt.splitright = true -- force all vertical splits to go to the right of current window
vim.opt.swapfile = false -- creates a swapfile
vim.opt.termguicolors = true -- set term gui colors (most terminals support this)
vim.opt.timeoutlen = 200 -- time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.undofile = true -- enable persistent undo
vim.o.updatetime = 150 -- faster completion (4000ms default)
vim.opt.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
vim.opt.expandtab = true -- convert tabs to spaces
vim.opt.shiftwidth = 2 -- the number of spaces inserted for each indentation
vim.opt.tabstop = 2 -- insert 2 spaces for a tab
vim.opt.cursorline = true -- highlight the current line
vim.opt.number = true -- set numbered lines
vim.opt.showcmd = false
vim.opt.ruler = false
vim.opt.numberwidth = 4 -- set number column width to 2 {default 4}
vim.opt.signcolumn = "yes" -- always show the sign column, otherwise it would shift the text each time
vim.opt.wrap = false -- display lines as one long line
vim.opt.scrolloff = 4 -- is one of my fav
vim.opt.sidescrolloff = 4
-- vim.opt.fillchars.eob=" "
vim.opt.shortmess:append("c")
vim.opt.whichwrap:append("<,>,[,],h,l")
vim.opt.iskeyword:append("-")
vim.opt.rtp:append("/opt/local/share/vim/vimfiles/ftdetect")

if vim.fn.executable("rg") == 1 then
	vim.opt.grepformat = "%f:%l:%c:%m,%f:%l:%m"
	vim.opt.grepprg = "rg --vimgrep --no-heading --smart-case"
end

vim.opt.wildignorecase = true -- Ignore case when completing file names and directories
vim.opt.wildcharm = 26 -- equals set wildcharm=<C-Z>, used in the mapping section

-- Binary
vim.opt.wildignore = {
	"*.aux,*.out,*.toc",
	"*.o,*.obj,*.dll,*.jar,*.pyc,__pycache__,*.rbc,*.class",
	-- media
	"*.ai,*.bmp,*.gif,*.ico,*.jpg,*.jpeg,*.png,*.psd,*.webp",
	"*.avi,*.m4a,*.mp3,*.oga,*.ogg,*.wav,*.webm",
	"*.eot,*.otf,*.ttf,*.woff",
	"*.doc,*.pdf",
	-- archives
	"*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz",
	-- temp/system
	"*.*~,*~ ",
	"*.swp,.lock,.DS_Store,._*,tags.lock",
	-- version control
	".git,.svn",
}
vim.opt.wildoptions = "pum"
vim.opt.pumblend = 10 -- Make popup window translucent
vim.opt.pumheight = 20 -- Limit the amount of autocomplete items shown

-- GUI Options
vim.opt.guifont = "PragmataPro Liga:h12"
vim.opt.linespace = 0

-- Neovide Global Options --
vim.g.neovide_transparency = 1.00
vim.g.neovide_no_idle = true

-- vim.g.node_host_prog = vim.fn.trim(vim.fn.system("volta which neovim-node-host"))

if vim.g.neoray then
	vim.g.guifont = "PragmataPro Liga:h12"
	local neoray_config = {
		"NeoraySet CursorAnimTime 0.08",
		"NeoraySet Transparency 0.95",
		"NeoraySet TargetTPS 120",
		"NeoraySet ContextMenu TRUE",
		"NeoraySet BoxDrawing TRUE",
		"NeoraySet ImageViewer TRUE",
		"NeoraySet WindowSize 100x40",
		"NeoraySet WindowState centered",
		"NeoraySet KeyFullscreen <M-C-CR>",
		"NeoraySet KeyZoomIn <C-ScrollWheelUp>",
		"NeoraySet KeyZoomOut <C-ScrollWheelDown>",
	}

	for _, config in ipairs(neoray_config) do
		vim.cmd(config)
	end
end
