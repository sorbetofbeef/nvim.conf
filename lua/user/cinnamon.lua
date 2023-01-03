local status_ok, cin = pcall(require, "cinnamon")
if not status_ok then
	return
end

cin.setup({
	extra_keymaps = true,
	extended_keymaps = false,
	centered = true,
	max_length = 200,
	scroll_limit = 150,
})
