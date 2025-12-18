return {
	"ThePrimeagen/harpoon",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local map = vim.keymap.set
		local hui = require("harpoon.ui")

		map("n", "<leader>hx", function()
			require("harpoon.mark").add_file()
		end, { desc = "Harpoon: Mark current buffer" })

		map("n", "<leader>hs", function()
			hui.toggle_quick_menu()
		end, { desc = "Harpoon: Toggle Menu" })

		map("n", "<leader>1", function()
			hui.nav_file(1)
		end, { desc = "Harpoon: Move to file 1" })
		map("n", "<leader>2", function()
			hui.nav_file(2)
		end, { desc = "Harpoon: Move to file 2" })
		map("n", "<leader>3", function()
			hui.nav_file(3)
		end, { desc = "Harpoon: Move to file 3" })
		map("n", "<leader>4", function()
			hui.nav_file(4)
		end, { desc = "Harpoon: Move to file 4" })
		map("n", "<leader>5", function()
			hui.nav_file(5)
		end, { desc = "Harpoon: Move to file 5" })
	end,
}
