return {
	"saghen/blink.cmp",
	dependencies = {
		"rafamadriz/friendly-snippets",
		"L3MON4D3/LuaSnip",
	},

	version = "1.*",

	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		keymap = {
			preset = "default",
			["<C-space"] = { "fallback" },
			["<C-s>"] = { "show", "show_documentation", "hide_documentation" },
			["<Tab>"] = { "fallback" },
			["<C-k>"] = { "snippet_forward" },
			["<C-j>"] = { "snippet_backward" },
		},

		appearance = {
			nerd_font_variant = "mono",
		},

		completion = {
			documentation = {
				auto_show = true,
				window = { border = "rounded" },
			},
			menu = {
				scrollbar = false,
				border = "rounded",
			},
			trigger = {
				show_on_keyword = true,
				show_on_trigger_character = true,
				show_on_blocked_trigger_characters = { "$", " ", "\n", "\t" },
				show_on_x_blocked_trigger_characters = { "$", "'", '"', "(", "{", "[" },
			},
		},

		snippets = { preset = "luasnip" },
		sources = {
			default = { "lsp", "path", "buffer", "snippets" },
			providers = {
				lsp = {
					name = "LSP",
					module = "blink.cmp.sources.lsp",
					opts = { tailwind_color_icon = "" },
					-- score_offset = 100,
					should_show_items = true,
				},
			},
		},

		fuzzy = {
			implementation = "prefer_rust_with_warning",
			sorts = {
				"score", -- Primary sort: by fuzzy matching score
				"sort_text", -- Secondary sort: by sortText field if scores are equal
				"label", -- Tertiary sort: by label if still tied
			},
		},
	},
	opts_extend = { "sources.default" },
	signature = {
		enabled = true,
		window = {
			border = "rounded",
		},
	},
}
