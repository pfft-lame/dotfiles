return {
	"lewis6991/gitsigns.nvim",
	config = function()
		local gitsigns = require("gitsigns")
		gitsigns.setup()

		local map = vim.keymap.set

		map("n", "]c", function()
			if vim.wo.diff then
				vim.cmd.normal({ "]c", bang = true })
			else
				gitsigns.nav_hunk("next")
			end
		end, { desc = "GitSigns: Nav to next hunk" })

		map("n", "[c", function()
			if vim.wo.diff then
				vim.cmd.normal({ "[c", bang = true })
			else
				gitsigns.nav_hunk("prev")
			end
		end, { desc = "GitSigns: Nav to prev hunk" })

		map("n", "<leader>gp", gitsigns.preview_hunk, { desc = "GitSigns: Preview hunk" })
		map("n", "<leader>gt", gitsigns.toggle_current_line_blame, { desc = "GitSigns: Toggle current line blame" })
		map("n", "<leader>hd", gitsigns.diffthis, { desc = "GitSigns: Preview entire file diff" })
	end,
}
