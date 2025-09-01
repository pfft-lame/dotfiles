return {
	"L3MON4D3/LuaSnip",
	version = "v2.*",
	dependencies = {
		{
			"rafamadriz/friendly-snippets",
			config = function()
				require("luasnip.loaders.from_vscode").lazy_load()
			end,
		},
	},
	opts = {
		history = true,
	},
	config = function()
		require("luasnip.loaders.from_lua").lazy_load({
			paths = { vim.fn.stdpath("config") .. "/snippets" },
		})

		local ls = require("luasnip")

		ls.config.set_config({
			history = true, -- Remember snippet state
			updateevents = "TextChanged,TextChangedI", -- Update as you type
			enable_autosnippets = true, -- Enable automatic snippets
		})

		vim.keymap.set({ "i", "s" }, "<C-k>", function()
			if ls.expand_or_jumpable() then
				ls.expand_or_jump()
			end
		end, { silent = true })

		vim.keymap.set({ "i", "s" }, "<C-j>", function()
			if ls.jumpable(-1) then
				ls.jump(-1)
			end
		end, { silent = true })
	end,
}
