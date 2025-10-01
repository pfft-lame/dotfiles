return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "saghen/blink.cmp" },
		{
			"folke/lazydev.nvim",
			ft = "lua",
			opts = {
				library = {
					{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				},
			},
		},
	},
	config = function()
		local lspconfig = require("lspconfig")
		local map = vim.keymap.set

		local lsp_capabilities = vim.lsp.protocol.make_client_capabilities()
		local capabilities = require("blink.cmp").get_lsp_capabilities(lsp_capabilities)

		lspconfig.lua_ls.setup({
			capabilities = capabilities,
			settings = {
				Lua = {
					runtime = { version = "LuaJIT" },
					diagnostics = { globals = { "vim" } },
					workspace = {
						library = vim.api.nvim_get_runtime_file("", true),
						checkThirdParty = false,
					},
					telemetry = { enable = false },
				},
			},
		})

		lspconfig.gopls.setup({
			capabilities = capabilities,
		})

		lspconfig.ts_ls.setup({
			capabilities = capabilities,
			filetypes = {
				"typescript",
				"typescriptreact",
				"typescript.tsx",
				"javascript",
				"javascriptreact",
				"javascript.jsx",
			},
			settings = {
				typescript = {
					inlayHints = {
						includeInlayParameterNameHints = "all",
						includeInlayParameterNameHintsWhenArgumentMatchesName = false,
						includeInlayFunctionParameterTypeHints = true,
						includeInlayVariableTypeHints = true,
						includeInlayPropertyDeclarationTypeHints = true,
						includeInlayFunctionLikeReturnTypeHints = true,
						includeInlayEnumMemberValueHints = true,
					},
					implementationsCodeLens = {
						enabled = true,
					},
					referencesCodeLens = {
						enabled = true,
					},
					suggest = {
						completeFunctionCalls = true,
					},
				},
				javascript = {
					inlayHints = {
						includeInlayParameterNameHints = "all",
						includeInlayParameterNameHintsWhenArgumentMatchesName = false,
						includeInlayFunctionParameterTypeHints = true,
						includeInlayVariableTypeHints = true,
						includeInlayPropertyDeclarationTypeHints = true,
						includeInlayFunctionLikeReturnTypeHints = true,
					},
				},
			},
			commands = {
				OrganizeImports = {
					function()
						vim.lsp.buf_request(0, "workspace/executeCommand", {
							command = "_typescript.organizeImports",
							arguments = { vim.api.nvim_buf_get_name(0) },
						})
					end,
					description = "Organize Imports",
				},
			},
			on_attach = function(client, bufnr)
				vim.keymap.set("n", "<leader>oi", "<cmd>OrganizeImports<CR>")
			end,
		})

		local svelte_lsp_capabilities = vim.tbl_deep_extend("force", {}, capabilities, {
			workspace = {
				didChangeWatchedFiles = vim.fn.has("nvim-0.10") == 0 and { dynamicRegistration = true },
			},
		})
		lspconfig.svelte.setup({
			capabilities = svelte_lsp_capabilities,
			filetypes = { "svelte" },
			settings = {
				svelte = {
					plugin = {
						svelte = {
							defaultScriptLanguage = "ts",
						},
					},
				},
			},
			on_attach = function(client, bufnr)
				vim.keymap.set("n", "<leader>oi", function()
					vim.lsp.buf.code_action({
						apply = true,
						context = {
							only = { "source.organizeImports" },
							diagnostics = {},
						},
					})
				end, { desc = "Organize Imports" })
			end,
		})

		lspconfig.tailwindcss.setup({
			capabilities = capabilities,
		})

		lspconfig.emmet_language_server.setup({
			capabilities = capabilities,
			filetypes = {
				"css",
				"eruby",
				"html",
				"javascript",
				"javascriptreact",
				"less",
				"sass",
				"scss",
				"pug",
				"typescriptreact",
			},
			init_options = {
				includeLanguages = {},
				excludeLanguages = {},
				extensionsPath = {},
				preferences = {},
				showAbbreviationSuggestions = true,
				showExpandedAbbreviation = "always",
				showSuggestionsAsSnippets = false,
				syntaxProfiles = {},
				variables = {},
			},
		})

		lspconfig.html.setup({
			capabilities = capabilities,
		})

		lspconfig.cssls.setup({
			capabilities = capabilities,
		})

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("custom-lsp-attach", { clear = true }),
			callback = function(event)
				local bufnr = event.buf
				local opts = { noremap = true, silent = true, buffer = bufnr }

				-- don't support json filetypes (we don't have lsp)
				local filetype = vim.bo[bufnr].filetype
				if filetype == "json" or filetype == "jsonc" then
					return
				end

				map("n", "gd", vim.lsp.buf.definition, opts)
				map("n", "gt", vim.lsp.buf.type_definition, opts)
				map("n", "K", vim.lsp.buf.hover, opts)
				map("n", "<leader>rn", vim.lsp.buf.rename, opts)
				map("n", "<leader>ca", vim.lsp.buf.code_action, opts)
				map("n", "gl", vim.diagnostic.open_float, opts)
				map("n", "[d", function()
					vim.diagnostic.jump({ count = -1 })
				end, opts)
				map("n", "]d", function()
					vim.diagnostic.jump({ count = 1 })
				end, opts)

				-- highlight the references
				local highlight_augroup = vim.api.nvim_create_augroup("custom-lsp-highlight", { clear = false })
				vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
					buffer = event.buf,
					group = highlight_augroup,
					callback = vim.lsp.buf.document_highlight,
				})

				vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
					buffer = event.buf,
					group = highlight_augroup,
					callback = vim.lsp.buf.clear_references,
				})

				vim.api.nvim_create_autocmd("LspDetach", {
					group = vim.api.nvim_create_augroup("custom-lsp-detach", { clear = true }),
					callback = function(event2)
						vim.lsp.buf.clear_references()
						vim.api.nvim_clear_autocmds({ group = "custom-lsp-highlight", buffer = event2.buf })
					end,
				})
			end,
		})

		require("lspconfig.ui.windows").default_options.border = "rounded"
	end,
}
