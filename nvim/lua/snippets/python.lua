local ls = require "luasnip"
local ps = ls.parser.parse_snippet

return {
  -- to add here
}, {
  ps({ trig = "ist" }, "ipdb.set_trace()"),
  ps({ trig = "ppp" }, 'print(f"{$0=}")'),
}
