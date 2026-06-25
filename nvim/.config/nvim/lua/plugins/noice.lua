return {
	"folke/noice.nvim",
	event = "VeryLazy",
	config = function()
		require("noice").setup({
			presets = {
				lsp_doc_border = true,
			},
			lsp = {
				progress = {
					enabled = true,
					throttle = 700 / 3,
				},
			},
			routes = {
				{
					filter = {
						any = {
							{ event = "lsp",    kind = "progress",    find = "basedpyright" },
							{ event = "notify", find = "basedpyright" },
						},
					},
					opts = { skip = true },
				},
			},
		})
	end,
}
