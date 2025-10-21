return {
	"williamboman/mason.nvim",
	lazy = false,
	auto_update = false,
	dependencies = {
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		require("mason").setup()

		require("mason-tool-installer").setup({
			ensure_installed = {
				"lua-language-server",
				"html-lsp",
				"css-lsp",
				"typescript-language-server",
				"tailwindcss-language-server",
				"gopls",
				"yaml-language-server",
				"emmet-language-server",
				"markdown-oxide",
				"svelte-language-server",
				"prettierd",
				"stylua",
				"gofumpt",
				"goimports",
				"eslint_d",
				"shfmt",
				"checkmake",
			},
		})
	end,
}
