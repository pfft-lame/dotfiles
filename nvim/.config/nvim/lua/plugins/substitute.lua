return {
	"gbprod/substitute.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local substitue = require("substitute")
		substitue.setup()

		vim.keymap.set("n", "s", substitue.operator, { desc = "Substitute with motion" })
		vim.keymap.set("n", "ss", substitue.line, { desc = "Substitute line" })
		vim.keymap.set("n", "S", substitue.eol, { desc = "Substitute to end of line" })
		vim.keymap.set("x", "s", substitue.visual, { desc = "Substitute in visual mode" })
	end,
}
