return {
	"ThePrimeagen/harpoon",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local map = vim.keymap.set
		local hui = require("harpoon.ui")

		map("n", "<leader>hx", function()
			require("harpoon.mark").add_file()
		end)

		map("n", "<leader>hs", function()
			hui.toggle_quick_menu()
		end)

		map("n", "<leader>1", function()
			hui.nav_file(1)
		end)
		map("n", "<leader>2", function()
			hui.nav_file(2)
		end)
		map("n", "<leader>3", function()
			hui.nav_file(3)
		end)
		map("n", "<leader>4", function()
			hui.nav_file(3)
		end)
		map("n", "<leader>5", function()
			hui.nav_file(4)
		end)
	end,
}
