local ls = require("luasnip")
-- local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
  ls.snippet({
    trig="iep",
    dscr="Error if block with panic"
  }, {
    t({ "if err != nil {", "\tpanic(err)", "}" }),
  }),
  ls.snippet({
    trig="iel",
    dscr="Error if block with log panic"
  }, {
    t({ "if err != nil {", "\tlog.Panic(err)", "}" }),
  }),
  ls.snippet({
    trig="ier",
    dscr="Error if block with return"
  }, {
    t({ "if err != nil {", "\treturn "}),
    i(1, ""),
    t({"err", "}" }),
  }),
}
