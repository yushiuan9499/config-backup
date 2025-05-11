local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local rep = require("luasnip.extras").rep

return {
  ls.add_snippets("cpp", {
    s("header_guard", {
      t("#ifndef "),
      i(1, "HEADER"),
      t("_H"),
      t({ "", "#define " }),
      rep(1),
      t("_H"),
      t({ "", "", "#endif // " }),
      rep(1),
      t("_H"),
    }),
  }),
}
