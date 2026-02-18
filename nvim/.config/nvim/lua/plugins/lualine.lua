return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("lualine").setup({
			options = {
				disabled_filetypes = { "snacks_picker_input" },
				icons_enabled = true,
				section_separators = { left = "", right = "" },
				component_separators = { left = "", right = "" },
				-- section_separators = { left = "", right = "" },
				-- component_separators = { left = "", right = "" },
			},
			sections = {
				lualine_a = { { "mode", icon = "" } },
				lualine_b = {
					{
						"branch",
						icon = "",
					},
				},
				lualine_c = {
					{ "filename" },
					{
						"diagnostics",
						symbols = { error = " ", warn = " ", info = " ", hint = " " },
					},
				},
				lualine_x = {
					{
						"diff",
						colored = false,
						symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
					},
					{ "filetype" },
				},
				lualine_y = { "location" },
				lualine_z = { "progress" },
			},
		})
	end,
}
