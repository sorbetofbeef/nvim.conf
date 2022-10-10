local status_ok, cin = pcall(require, "cinnamon")
if not status_ok then
  return
end

cin.setup {
  extra_keymaps = true,
  extended_keymaps = true,
  max_length = 500,
  scroll_limit = -1,
}
