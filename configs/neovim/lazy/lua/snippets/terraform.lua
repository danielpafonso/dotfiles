local ls = require("luasnip")
local t = ls.text_node
local i = ls.insert_node

return {
  ls.snippet({
    trig="res",
    dscr="Resource block",
  }, {
    t({ "resource \"" }),
    i(1, "type"),
    t({ "\" \"" }),
    i(2, "name"),
    t({ "\" {", "\t" }),
    i(3, ""),
    t({ "", "}" }),
  }),

  ls.snippet({
    trig="mod",
    dscr="Module block with source path",
  }, {
    t({ "module \"" }),
    i(1, "name"),
    t({ "\" {", "\tsource = \"" }),
    i(2, "path"),
    t({ "\"", "\t" }),
    i(3, ""),
    t({ "", "}" }),
  }),
}
