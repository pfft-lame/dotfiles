return {
	"windwp/nvim-autopairs",
	event = "InsertEnter",
	opts = {
		fast_wrap = {},
		disable_filetype = { "snacks_picker_input", "vim" },
	},
	config = function(_, opts)
		require("nvim-autopairs").setup(opts)
	end,
}
