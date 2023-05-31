local present, ls = pcall(require, "luasnip")
if not present then
  return
end

local fmt = require("luasnip.extras.fmt").fmt
local snippet = ls.snippet
local insert_node = ls.insert_node
local function_node = ls.function_node
local dynamic_node = ls.dynamic_node
local snippet_node = ls.snippet_node
local rep = require("luasnip.extras").rep

