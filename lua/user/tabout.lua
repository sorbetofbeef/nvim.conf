local t_out_status_ok, tab = pcall(require, "tabout")
if not t_out_status_ok then
  return
end

tab.setup {
  tabkey = '<Tab>',
  backwards_tabkey = "<S-Tab>",
  act_as_tab = true,
  act_as_shift_tab = false,
  default_tab = '<C-t>',
  default_shift_tab = '<C-d>',
  enable_backwards = true,
  completion = false,
  tabouts = {
    {open = "'", close = "'"},
    {open = '"', close = '"'},
    {open = '`', close = '`'},
    {open = '(', close = ')'},
    {open = '[', close = ']'},
    {open = '{', close = '}'}
  },
  ignore_beginning = true,
  exclude = {},
}

