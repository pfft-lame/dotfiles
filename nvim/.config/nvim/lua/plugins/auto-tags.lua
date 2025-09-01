return {
	"windwp/nvim-ts-autotag",
	event = { "BufReadPre", "BufNewFile" },
	ft = {
		"html",
		"javascript",
		"typescript",
		"javascriptreact",
		"typescriptreact",
		"svelte",
		"vue",
		"rescript",
		"xml",
		"php",
		"markdown",
		"astro",
		"glimmer",
		"handlebars",
		"hbs",
	},
	config = function()
		require("nvim-ts-autotag").setup()
	end,
}
