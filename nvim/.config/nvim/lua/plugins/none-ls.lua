return {
	"nvimtools/none-ls.nvim",
	dependencies = {
		"nvimtools/none-ls-extras.nvim",
		"williamboman/mason.nvim",
	},
	config = function()
		local null_ls = require("null-ls")
		local formatting = null_ls.builtins.formatting -- to setup formatters
		local diagnostics = null_ls.builtins.diagnostics -- to setup linters

		local sources = {
			diagnostics.checkmake,
			formatting.prettierd.with({
				filetypes = {
					"html",
					"json",
					"yaml",
					"markdown",
					".prettierrc",
					"svelte",
					"javascript",
					"typescript",
					"javascriptreact",
					"typescriptreact",
					"css",
					"graphql",
					"svelte",
					"jsonc",
				},
			}),
			formatting.stylua,
			formatting.goimports,
			formatting.gofumpt,
			formatting.clang_format.with({
				extra_args = { "--style=Google" },
			}),
			formatting.shfmt.with({ args = { "-i", "4" } }),
			formatting.terraform_fmt,
			require("none-ls.diagnostics.eslint_d").with({
				condition = function(utils)
					return utils.root_has_file({
						".eslintrc",
						".eslintrc.js",
						".eslintrc.cjs",
						".eslintrc.yaml",
						".eslintrc.yml",
						".eslintrc.json",
						"eslint.config.js",
						"eslint.config.mjs",
						"eslint.config.cjs",
					})
				end,
			}),
			require("none-ls.formatting.ruff").with({ extra_args = { "--extend-select", "I" } }),
			require("none-ls.formatting.ruff_format"),
			require("none-ls.diagnostics.ruff"),
		}

		local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
		null_ls.setup({
			-- debug = true, -- Enable debug mode. Inspect logs with :NullLsLog.
			sources = sources,
			-- you can reuse a shared lspconfig on_attach callback here
			on_attach = function(client, bufnr)
				client.log_level = "WARN"

				if client:supports_method("textDocument/formatting") then
					vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = augroup,
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format({ async = false })
						end,
					})
				end
			end,
		})
	end,
}
