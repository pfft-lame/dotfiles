return {
	"folke/todo-comments.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local tdc = require("todo-comments")

		vim.keymap.set("n", "]t", function()
			tdc.jump_next()
		end, { desc = "Comments: Next todo comment" })

		vim.keymap.set("n", "[t", function()
			tdc.jump_prev()
		end, { desc = "Comments: Previous todo comment" })

		tdc.setup()
	end,
}
