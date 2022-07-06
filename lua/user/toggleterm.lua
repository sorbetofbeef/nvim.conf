local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
	return
end

toggleterm.setup({
	size = 30,
  open_mapping = [[<c-\>]],
	hide_numbers = true,
	shade_terminals = true,
	shading_factor = 2,
	start_in_insert = true,
	insert_mappings = true,
	persist_size = true,
	direction = "horizontal",
	close_on_exit = false,
	shell = vim.o.shell,
	float_opts = {
		border = "curved",
	},
})

function _G.set_terminal_keymaps()
  local opts = {noremap = true}
  vim.api.nvim_buf_set_keymap(0, 't', 'jk', [[<C-\><C-n>]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-l>', [[<C-\><C-n><C-W>l]], opts)
end

vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })
local htop = Terminal:new({cmd = "htop", hidden = true })
local float_term = Terminal:new({direction = "float"})

function _LAZYGIT_TOGGLE()
	lazygit:toggle()
end

function _FLOAT_TOGGLE()
	float_term:toggle()
end

function _HTOP_TOGGLE()
	htop:toggle()
end

--[[ local wk_status_ok, wk = pcall(require, "which-key")
if not wk_status_ok then
  return
end
]]
--[[ local function toggle ()
  local opts = {
    prefix = "<leader>",
    mode = "n",
    buffer = 0,
  }
  local mappings = {
    t = {
      name = "Terminal",
      t = {":ToggleTerm<CR>", "Term"},
      T = {":ToggleTermToggleAll<CR>", "Term"},
      f = {"<cmd>lua _FLOAT_TOGGLE<CR>", "Float Term"},
      g = {"<cmd>lua _LAZYGIT_TOGGLE<CR>", "Lazygit"},
      h = {"<cmd>lua _HTOP_TOGGLE<CR>", "htop"},
    }
  }

  wk.register(mappings, opts)
end

toggle() ]]
