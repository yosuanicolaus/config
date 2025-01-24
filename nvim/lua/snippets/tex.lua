local utils = {
  pipe = function(fns)
    return function(...)
      for _, fn in ipairs(fns) do
        if not fn(...) then
          return false
        end
      end
      return true
    end
  end,
  no_backslash = function(line_to_cursor, matched_trigger)
    return not line_to_cursor:find("\\%a+$", -#line_to_cursor)
  end,
  is_math = function()
    return vim.fn["vimtex#syntax#in_mathzone"]() == 1
  end,
  not_math = function()
    return vim.fn["vimtex#syntax#in_mathzone"]() ~= 1
  end,
  comment = function()
    return vim.fn["vimtex#syntax#in_comment"]() == 1
  end,
  with_priority = function(snip, priority)
    snip.priority = priority
    return snip
  end,
}

local ls = require "luasnip"
local ps = ls.parser.parse_snippet
local is_math = utils.is_math
local not_math = utils.not_math

-- Let's do this later...

return {}
