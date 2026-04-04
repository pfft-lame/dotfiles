local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("go", {
	s("ier", {
		t({ "if err != nil {", "\t" }),
		i(1),
		t({ "", "}" }),
	}),
})

ls.add_snippets("go", {
	s(
		"ile",
		fmt(
			[[
if err := {}; err != nil {{
    {}
}}
	]],
			{ i(1), i(2) }
		)
	),
})
