local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local rep = require("luasnip.extras").rep

return {
  ls.add_snippets("make", {
    s("make", {
      t("CXX = g++"),
      t({ "", "CXXFLAGS = -Wall -Wextra -std=c++17" }),
      t({ "", "LDFLAGS =" }),
      t({ "", "SOURCES = src/main.cpp" }),
      t({ "", "OBJECTS = build/*.o" }),
      t({ "", "EXECUTABLE = program" }),
      t({ "", "" }),
      t({ "", ".PHONY: all clean", "" }),
      t("all: $(EXECUTABLE)"),
      t({ "", "$(EXECUTABLE): $(OBJECTS)" }),
      t({ "", "\t$(CXX) $(LDFLAGS) -o $@ $^" }),
      t({ "", "" }),
      t("clean:"),
      t({ "", "\trm -f build/*.o $(EXECUTABLE)" }),
    }),
    s("obj", {
      t("build/"),
      i(1, "object"),
      t(".o : src/source/"),
      rep(1),
      t(".cpp "),
      t("src/header/"),
      rep(1),
      t(".h"),
      t({ "", "\t$(CXX) $(CXXFLAGS) -c $< -o $@" }),
    }),
  }),
}
