return {
	"voldikss/vim-floaterm",
	event = "VeryLazy",
	config = function()
		local map = vim.keymap.set
		map("n", "<C-_>", "<cmd>FloatermToggle<cr>")
		map("t", "<C-_>", "<C-\\><C-n><cmd>FloatermToggle<CR>")
		map("n", "<C-/>", "<cmd>FloatermToggle<cr>")
		map("t", "<C-/>", "<C-\\><C-n><cmd>FloatermToggle<CR>")
		map("t", "<C-o>", "<cmd>FloatermNew<cr>")
		map("t", "<C-l>", "<cmd>FloatermKill<cr>")
		map("t", "<C-j>", "<cmd>FloatermNext<cr>")
		map("t", "<C-k>", "<cmd>FloatermPrev<cr>")
	end,
}
