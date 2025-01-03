local ls = require "luasnip"
local utils = require "luasnip-latex-snippets.util.utils"
local conds = require "luasnip.extras.expand_conditions"
local pipe = utils.pipe
local t = ls.text_node
local i = ls.insert_node

-- Manually extend and override change the retrieve function

-- Will be called and added as AutoSnippets
require("luasnip-latex-snippets.wA").retrieve = function(not_math)
  local ps_nm = ls.extend_decorator.apply(ls.parser.parse_snippet, {
    condition = pipe { not_math },
  }) --[[@as function]]
  local s_lb_nm = ls.extend_decorator.apply(ls.snippet, { condition = pipe { conds.line_begin, not_math } }) --[[@as function]]

  return {
    ps_nm({ trig = "mk", name = "Math" }, "\\( ${1:${TM_SELECTED_TEXT}} \\)$0"),
    ps_nm({ trig = "dm", name = "Block Math" }, "\\[\n\t${1:${TM_SELECTED_TEXT}}\n\\] $0"), -- remove "." at the end
    s_lb_nm({ trig = "ali", name = "Align" }, { t { "\\begin{align*}", "\t" }, i(1), t { "", "\\end{align*}" } }), -- remove "." at the end
  }
end
