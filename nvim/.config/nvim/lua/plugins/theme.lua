return {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        ---@diagnostic disable-next-line: missing-fields
        require("tokyonight").setup({
            styles = {
                comments = { italic = true },
                keywords = { italic = true },
            },
            transparent = true,
            terminal_colors = true,
            on_highlights = function(hl, colors)
                hl.DiagnosticUnderlineError = { underline = true, sp = colors.error }
                hl.DiagnosticUnderlineWarn = { underline = true, sp = colors.yellow }
                hl.DiagnosticUnderlineInfo = { underline = true, sp = colors.info }
                hl.DiagnosticUnderlineHint = { underline = true, sp = colors.hint }

                hl.DiagnosticVirtualTextError = { bg = "", fg = colors.error }
                hl.DiagnosticVirtualTextWarn = { bg = "", fg = colors.yellow }
                hl.DiagnosticVirtualTextInfo = { bg = "", fg = colors.info }
                hl.DiagnosticVirtualTextHint = { bg = "", fg = colors.hint }
            end,
        })
        vim.cmd.colorscheme("tokyonight-night")
    end,
}
