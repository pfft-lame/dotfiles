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

		local function get_dir(path)
			local dir

			if vim.fn.isdirectory(path) == 1 then
				dir = vim.fn.fnamemodify(path, ":p")
			elseif vim.fn.filereadable(path) == 1 then
				dir = vim.fn.fnamemodify(path, ":p:h")
			else
				dir = vim.fn.fnamemodify(vim.fn.getcwd(), ":p")
			end

			dir = vim.fn.fnamemodify(dir, ":~")
			dir = vim.fn.escape(dir, ' %#|"')

			return dir
		end

		vim.keymap.set("n", "<C-c>", function()
			local dir = get_dir(vim.fn.expand("%"))
			vim.cmd("FloatermNew --cwd=" .. dir)
		end, { silent = true })
	end,
}
