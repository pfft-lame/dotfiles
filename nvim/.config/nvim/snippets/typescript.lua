local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("typescript", {
  s("@tsign", { t("// @ts-ignore ") }),
})

ls.add_snippets("typescript", {
  s("@ter", { t("// @ts-expect-err ") }),
})

ls.add_snippets("typescript", {
  s("@esdis", { t("// @eslint-disable-next-line ") }),
})

--------------------------------
-- Svetekit specific snippets --
--------------------------------

local function detect_load_type(_, _)
  local filename = vim.fn.expand("%:t")

  local file_types = {
    ["+page.server.ts"] = "PageServerLoad",
    ["+page.ts"] = "PageLoad",
    ["+layout.server.ts"] = "LayoutServerLoad",
    ["+layout.ts"] = "LayoutLoad",
  }

  for pattern, type_name in pairs(file_types) do
    if filename == pattern then
      return type_name
    end
  end

  return "PageServerLoad"
end

ls.add_snippets("typescript", {
  s(
    "kit-load",
    fmt(
      [[
import type {{ {} }} from './$types';

export const load: {} = async ({{ {} }}) => {{
    {}

    return {{
        {}
    }};
}};
]],
      { f(detect_load_type), f(detect_load_type), i(1), i(2), i(3, "prop: 'value'") }
    )
  ),
})

ls.add_snippets("typescript", {
  s(
    "kit-actions",
    fmt(
      [[
export const actions: Actions = {{
    default: async ({{ {} }}) => {{
        {}
        return {{
            {}
        }};
    }}
}};
    ]],
      { i(1), i(2), i(3) }
    )
  ),
})
