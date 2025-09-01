return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,

	init = function()
		vim.api.nvim_create_autocmd("User", {
			pattern = "OilActionsPost",
			callback = function(event)
				if event.data.actions.type == "move" then
					Snacks.rename.on_rename_file(event.data.actions.src_url, event.data.actions.dest_url)
				end
			end,
		})
	end,

	keys = require("plugins.snacks.keys"),

	opts = {
		dashboard = require("plugins.snacks.dashboard"),
		indent = require("plugins.snacks.indent"),
		picker = require("plugins.snacks.picker"),

		bigfile = { enabled = true },
		explorer = { enabled = false },
		input = { enabled = false },
		scope = { enabled = false },
		notifier = { enabled = true },
		quickfile = { enabled = true },
		statuscolumn = { enabled = false },
		words = { enabled = false },
		rename = { enabled = false },
		zen = { enabled = false },
		terminal = { enabled = false },
	},

	config = function(_, opts)
		require("snacks").setup(opts)

		Snacks.toggle.new({
			id = "ufo",
			name = "Enable/Disable ufo",
			get = function()
				return require("ufo").inspect()
			end,
			set = function(state)
				if state == nil then
					require("noice").enable()
					require("ufo").enable()
					vim.o.foldenable = true
					vim.o.foldcolumn = "1"
				else
					require("noice").disable()
					require("ufo").disable()
					vim.o.foldenable = false
					vim.o.foldcolumn = "0"
				end
			end,
		})
	end,
}
