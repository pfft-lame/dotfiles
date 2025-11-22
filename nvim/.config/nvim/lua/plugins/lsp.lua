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
					hint = {
						enable = true, -- necessary
					},
				},
			},
		})

		lspconfig.gopls.setup({
			capabilities = capabilities,
			settings = {
				gopls = {
					hints = {
						rangeVariableTypes = true,
						parameterNames = true,
						constantValues = true,
						assignVariableTypes = true,
						compositeLiteralFields = true,
						compositeLiteralTypes = true,
						functionTypeParameters = true,
					},
				},
			},
		})

		lspconfig.sqls.setup({
			capabilities = capabilities,
		})

		lspconfig.ts_ls.setup({
			capabilities = capabilities,
			settings = {
				typescript = {
					inlayHints = {
						includeInlayParameterNameHints = "all",
						includeInlayParameterNameHintsWhenArgumentMatchesName = true,
						includeInlayFunctionParameterTypeHints = true,
						includeInlayVariableTypeHints = true,
						includeInlayVariableTypeHintsWhenTypeMatchesName = true,
						includeInlayPropertyDeclarationTypeHints = true,
						includeInlayFunctionLikeReturnTypeHints = true,
						includeInlayEnumMemberValueHints = true,
					},
				},
				javascript = {
					inlayHints = {
						includeInlayParameterNameHints = "all",
						includeInlayParameterNameHintsWhenArgumentMatchesName = true,
						includeInlayFunctionParameterTypeHints = true,
						includeInlayVariableTypeHints = true,
						includeInlayVariableTypeHintsWhenTypeMatchesName = true,
						includeInlayPropertyDeclarationTypeHints = true,
						includeInlayFunctionLikeReturnTypeHints = true,
						includeInlayEnumMemberValueHints = true,
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
			settings = {
				typescript = {
					inlayHints = {
						parameterNames = { enabled = "all" },
						parameterTypes = { enabled = true },
						variableTypes = { enabled = true },
						propertyDeclarationTypes = { enabled = true },
						functionLikeReturnTypes = { enabled = true },
						enumMemberValues = { enabled = true },
					},
				},
			},
		})

		lspconfig.clangd.setup({
			capabilities = capabilities,
			settings = {
				clangd = {
					InlayHints = {
						Designators = true,
						Enabled = true,
						ParameterNames = true,
						DeducedTypes = true,
					},
					fallbackFlags = { "-std=c++20" },
				},
			},
		})

		lspconfig.basedpyright.setup({
			capabilities = capabilities,
			settings = {
				basedpyright = {
					analysis = {
						autoSearchPaths = true,
						diagnosticMode = "openFilesOnly",
						useLibraryCodeForTypes = true,
					},
				},
			},
		})

		lspconfig.tailwindcss.setup({
			capabilities = capabilities,
		})

		lspconfig.emmet_language_server.setup({
			capabilities = capabilities,
		})

		lspconfig.html.setup({
			capabilities = capabilities,
		})

		lspconfig.cssls.setup({
			capabilities = capabilities,
		})

		lspconfig.yamlls.setup({
			capabilities = capabilities,
		})

		lspconfig.jsonls.setup({
			capabilities = capabilities,
		})

		lspconfig.eslint.setup({
			capabilities = capabilities,
		})

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("custom-lsp-attach", { clear = true }),
			callback = function(event)
				local bufnr = event.buf
				local opts = { noremap = true, silent = true, buffer = bufnr }

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

				local function client_supports_method(client, method, bufnr)
					if vim.fn.has("nvim-0.11") == 1 then
						return client:supports_method(method, bufnr)
					else
						return client.supports_method(method, { bufnr = bufnr })
					end
				end

				local client = vim.lsp.get_client_by_id(event.data.client_id)
				if
					client
					and client_supports_method(
						client,
						vim.lsp.protocol.Methods.textDocument_documentHighlight,
						event.buf
					)
				then
					local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
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
						group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
						callback = function(event2)
							vim.lsp.buf.clear_references()
							vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
						end,
					})
				end

				if
					client
					and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf)
				then
					map("n", "<leader>th", function()
						vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
					end)
					-- vim.lsp.inlay_hint.enable(true, { bufnr = event.buf })
				end
			end,
		})

		require("lspconfig.ui.windows").default_options.border = "rounded"
	end,
}
