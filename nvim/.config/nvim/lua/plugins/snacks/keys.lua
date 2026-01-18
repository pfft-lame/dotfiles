return {
	{
		"<leader>bd",
		function()
			Snacks.bufdelete()
		end,
		desc = "Buffer delete",
		mode = "n",
	},
	{
		"<leader>ba",
		function()
			Snacks.bufdelete.all()
		end,
		desc = "Buffer delete all",
		mode = "n",
	},
	{
		"<leader>bo",
		function()
			Snacks.bufdelete.other()
		end,
		desc = "Buffer delete other",
		mode = "n",
	},
	{
		"<leader>bz",
		function()
			Snacks.zen()
		end,
		desc = "Toggle Zen Mode",
		mode = "n",
	},
	{
		"<leader>fd",
		function()
			Snacks.picker.files()
		end,
		desc = "Find files",
		mode = "n",
	},
	{
		"<leader>fw",
		function()
			Snacks.picker.grep()
		end,
		desc = "Grep word",
		mode = "n",
	},
	{
		"<leader><leader>",
		function()
			Snacks.picker.buffers()
		end,
		desc = "Find buffers",
		mode = "n",
	},
	{
		"<leader>fk",
		function()
			Snacks.picker.keymaps()
		end,
		desc = "Find Keymaps",
		mode = "n",
	},
	{
		"<leader>ff",
		function()
			Snacks.picker.lsp_symbols({
				filter = {
					default = {
						"Function",
						"Method",
						"Constructor",
					},
				},
			})
		end,
		desc = "Find functions in a buffer",
		mode = "n",
	},
	{
		"gi",
		function()
			Snacks.picker.lsp_references()
		end,
		desc = "Show lsp references",
		mode = "n",
	},
	{
		"<leader>nh",
		function()
			Snacks.notifier.show_history()
		end,
		desc = "Open notification history",
		mode = "n",
	},
	{
		"<leader>ll",
		function()
			Snacks.lazygit()
		end,
		desc = "open lazygit",
		mode = "n",
	},
}
