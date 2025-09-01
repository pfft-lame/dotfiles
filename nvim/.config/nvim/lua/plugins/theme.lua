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
	end,

	-- "catppuccin/nvim",
	-- name = "catppuccin",
	-- priority = 1000,
	-- config = function()
	-- 	require("catppuccin").setup({
	-- 		transparent_background = true,
	-- 	})
	-- 	vim.cmd.colorscheme("catppuccin-mocha")
	-- end,

	-- "rose-pine/neovim",
	-- name = "rose-pine",
	-- config = function()
	-- 	require("rose-pine").setup({
	-- 		styles = {
	-- 			bold = true,
	-- 			italic = false,
	-- 			transparency = true,
	-- 		},
	-- 	})
	-- 	vim.cmd("colorscheme rose-pine")
	-- end,
}
