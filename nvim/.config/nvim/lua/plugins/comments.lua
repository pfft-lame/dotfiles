return {
	"numToStr/Comment.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
	config = function()
		local comment = require("Comment")
		local ts_ctx_cmtstr = require("ts_context_commentstring.integrations.comment_nvim")

		---@diagnostic disable-next-line: missing-fields
		comment.setup({
			-- for jsx, tsx, svelte, html files
			pre_hook = ts_ctx_cmtstr.create_pre_hook(),
		})
	end,
}
