return {
	"rcarriga/nvim-dap-ui",
	dependencies = { "mfussenegger/nvim-dap" },
	config = function()
		require("dapui").setup({
			layout = {
				elements = {
					{
						id = "scopes",
						size = 0.25, -- Can be float or integer > 1
						position = "right",
					},
					{
						id = "breakpoints",
						size = 0.25,
						position = "right",
					},
				},
			},
		})
	end,
}
