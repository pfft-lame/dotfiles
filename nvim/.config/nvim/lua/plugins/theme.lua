return {
	"folke/tokyonight.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		---@diagnostic disable-next-line: missing-fields
		require("tokyonight").setup({
			styles = {
				comments = { italic = true },
				keywords = { italic = true },
			},
			transparent = true,
			terminal_colors = true,
		})
		vim.cmd.colorscheme("tokyonight-night")

		vim.api.nvim_create_autocmd("ColorScheme", {
			callback = function()
				vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", {
					underline = true,
					bold = true,
				})
			end,
		})
	end,
}
