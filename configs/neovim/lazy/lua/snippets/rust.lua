local ls = require("luasnip")
-- local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
  ls.snippet({
    trig="ppl",
    dscr="Print ln macro with prety debug format"
  }, {
    t({ "println!(\"{:#?}\", "}),
    i(1, ""),
    t({");" }),
  }),
}
