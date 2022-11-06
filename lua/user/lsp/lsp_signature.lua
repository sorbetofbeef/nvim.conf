local okay, sigs = pcall(require, "lsp_signature")
if not okay then
	return
end

local cfg = {
	bind = true,
	handler_opts = {
		border = "rounded",
	},
	hint_prefix = "  ",
}

sigs.setup(cfg)
