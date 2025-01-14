local ls = require "luasnip"
local ps = ls.parser.parse_snippet

return {
  ps({ trig = "irs" }, "input.read_size()$0"),
  ps({ trig = "iri" }, "input.read_int()$0"),
  ps({ trig = "irl" }, "input.read_line()$0"),
  ps({ trig = "irvi" }, "input.read_vec_int($1)$0"),
  ps({ trig = "irvc" }, "input.read_vec_char()$0"),
  ps({ trig = "op" }, "out.println($1)$0"),
}, {
  ps({ trig = "irs;" }, "input.read_size();$0"),
  ps({ trig = "iri;" }, "input.read_int();$0"),
  ps({ trig = "v!" }, "vec![$1]$0"),
  ps({ trig = "op;" }, "out.println($1);$0"),
}
