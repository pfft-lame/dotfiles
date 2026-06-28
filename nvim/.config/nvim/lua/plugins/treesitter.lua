return {
  "nvim-treesitter/nvim-treesitter",
  commit = "90cd658",
  -- enabled = false,
  main = "nvim-treesitter",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    install = {
      "comment",
      "regex",
      "vimdoc",
      "c",
      "lua",
      "query",
      "markdown",
      "markdown_inline",
      "go",
      "svelte",
      "javascript",
      "typescript",
      "yaml",
      "json",
      "html",
      "css",
    },
  },
  config = function(_, opts)
    local treesitter = require("nvim-treesitter")
    treesitter.setup(opts)

    if vim.fn.executable("tree-sitter") ~= 1 then
      vim.api.nvim_echo({
        {
          "tree-sitter CLI not found. Parsers cannot be installed.",
          "ErrorMsg",
        },
      }, true, {})
      return false
    end

    treesitter.install(opts.install)

    local highlight = function(bufnr, lang)
      if not vim.treesitter.language.add(lang) then
        return vim.notify(
          string.format("Treesitter cannot load parser for language: %s", lang),
          vim.log.levels.INFO,
          { title = "Treesitter" }
        )
      end
      vim.treesitter.start(bufnr)
    end

    vim.api.nvim_create_autocmd("FileType", {
      callback = function(args)
        local buf = args.buf
        local ft = vim.bo[buf].filetype

        local lang = vim.treesitter.language.get_lang(ft)
        if not lang then
          return
        end

        if not pcall(vim.treesitter.language.add, lang) then
          return
        end

        if vim.list_contains(treesitter.get_installed(), ft) then
          highlight(buf, ft)
        elseif vim.list_contains(treesitter.get_available(), ft) then
          treesitter.install(ft):await(function()
            highlight(buf, ft)
          end)
        end

        -- if not vim.tbl_contains({ "python", "html", "yaml", "markdown" }, ft) then
        --   vim.bo[buf].indentexpr = "v:lua.require('nvim-treesitter').indentexpr()"
        --   vim.bo[buf].smartindent = false
        --   vim.bo[buf].cindent = false
        -- end
      end,
    })
  end,
}
