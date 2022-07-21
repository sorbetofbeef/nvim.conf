vim.g.coq_settings = {
  auto_start = 'shut-up',
  xdg = true,
  keymap = {
    recommended = true,
  },
  display = {
    ghost_text = {
      enabled = true,
      highlight_group = 'Error',
    },
    pum = {
      fast_close = false,
    },
    preview = {
      border = 'rounded',
    },
    icons = {
      mode = 'long',
      spacing = 2,
    },
  },
}

local coq_status_ok, _ = pcall(require, "coq")
if not coq_status_ok then
  return
end
