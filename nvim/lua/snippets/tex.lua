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

local function template_string(file_path)
  local title_str = "\\title{${1:MXXX TMA-0X}}\n"
  local maketitle_str = "\\maketitle\n"

  if file_path == "/template/tma_natural.tex" then
    title_str = "\\chead{${1:M140-02-Prices}}\n"
    maketitle_str = ""
  end

  return "\\documentclass[a4paper,12pt]{article}\n"
    .. "\\input{"
    .. vim.fn.getcwd()
    .. file_path
    .. "}\n"
    .. title_str
    .. "\\date{"
    .. os.date "%Y-%m-%d"
    .. "}\n"
    .. "\\begin{document}\n"
    .. maketitle_str
    .. "\n${2:Hello, world!}\n\n\\end{document}"
end

local ls = require "luasnip"
local ps = ls.parser.parse_snippet
local is_math = utils.is_math
local not_math = utils.not_math
local pipe = utils.pipe

local ps_nm = ls.extend_decorator.apply(ps, { condition = pipe { not_math } }) --[[@as function]]
local ps_im = ls.extend_decorator.apply(ps, { condition = pipe { is_math } }) --[[@as function]]

-- Let's do this later...

return {
  ps_nm({ trig = "bq" }, "\\begin{question}\n\t$0\n\\end{question}"),
  ps_nm({ trig = "qp" }, "\\qpart\n$0"),
  ps_nm({ trig = "qsp" }, "\\qsubpart\n$0"),
  ps_nm(
    { trig = "np" },
    "\\newpage %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n$0"
  ),

  ps_nm({ trig = "s*" }, "\\section*{$1}$0"),
  ps_nm({ trig = "s*r" }, "\\section*{Reading Notes}\n\n$0"),
  ps_nm({ trig = "s*a" }, "\\section*{Activities}\n\n\\begin{question}[1]\n\t$0\n\\end{question}"),
  ps_nm({ trig = "s*e" }, "\\section*{Excercises}\n\n\\begin{question}[1]\n\t$0\n\\end{question}"),

  ps_nm({ trig = "tempdefault" }, template_string "/template/default.tex"),
  ps_nm({ trig = "temptma" }, template_string "/template/tma_real.tex"),
  ps_nm({ trig = "template" }, template_string "/template/tma_natural.tex"),
}, {
  ps_im({ trig = ",," }, "\\,"),
  ps_im({ trig = "angle" }, "\\angle"),
  ps_im({ trig = "degs" }, "^{\\circ}"),
  ps_nm({ trig = "ii" }, "\\item"),
  ps_nm({ trig = "sii" }, "\\subitem"),
  ps_nm({ trig = ":np" }, "\\newpage %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"),
  ps_nm({ trig = ":qp" }, "\\qpart"),
  ps_nm({ trig = ":qsp" }, "\\qsubpart"),
}
