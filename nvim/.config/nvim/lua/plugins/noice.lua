return {
	"folke/noice.nvim",
	event = "VeryLazy",
	config = function()
		require("noice").setup({
			presets = {
				lsp_doc_border = true,
			},

			routes = {
				{
					filter = {
						event = { "msg_show", "lsp" },
						kind = { "stats", "debug", "message", "progress" },
						find = {
							"formatting", -- Hides messages like "formatting with prettierd"
							"diagnostics", -- Hides messages like "diagnostics from eslint_d"
						},
					},
					opts = { skip = true },
				},
				{
					filter = {
						event = { "msg_show", "lsp" },
						kind = { "stats", "debug", "message", "progress" },
						find = {
							"formatting", -- Hides messages like "formatting with prettierd"
							"diagnostics", -- Hides messages like "diagnostics from eslint_d"
						},
					},
					opts = { skip = true },
				},
			},
		})
	end,
}
