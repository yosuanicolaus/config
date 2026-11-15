local MATH_NODES = { displayed_equation = true, inline_formula = true, math_environment = true }
local TEXT_NODES = { text_mode = true, label_definition = true, label_reference = true }

-- walk up from the character just before the cursor
local function ts_math()
  local ok, parser = pcall(vim.treesitter.get_parser, 0, "latex")
  if not ok or not parser then
    return false
  end
  parser:parse() -- make sure the tree includes what was just typed
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  local node = vim.treesitter.get_node { pos = { row - 1, math.max(col - 1, 0) } }
  while node do
    local t = node:type()
    if TEXT_NODES[t] then
      return false -- e.g. \text{...} inside math
    elseif MATH_NODES[t] then
      return true
    end
    node = node:parent()
  end
  return false
end

local function ts_comment()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  local node = vim.treesitter.get_node { pos = { row - 1, math.max(col - 1, 0) } }
  return node ~= nil and node:type() == "comment"
end

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
  is_math = ts_math,
  not_math = function()
    return not ts_math()
  end,
  comment = ts_comment,
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
  -- PROMPT OUTSIDE MATH MODE
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

  -- [261115] claude: markdown < latex for math notes writing
  ps_nm({ trig = "ul" }, "\\begin{itemize}\n\t\\item $0\n\\end{itemize}"),
  ps_nm({ trig = "ol" }, "\\begin{enumerate}\n\t\\item $0\n\\end{enumerate}"),
  ps_nm({ trig = "thm" }, "\\begin{theorem}[$1]\n\t$0\n\\end{theorem}"),
  ps_nm({ trig = "def" }, "\\begin{definition}[$1]\n\t$0\n\\end{definition}"),
  ps_nm({ trig = "prf" }, "\\begin{proof}\n\t$0\n\\end{proof}"),
  ps_nm({ trig = "bf" }, "\\textbf{$1}$0"),
  ps_nm({ trig = "em" }, "\\emph{$1}$0"),
}, {
  -- INSTANT INSIDE MATH MODE
  ps_im({ trig = ",," }, "\\,"),
  ps_im({ trig = "angle" }, "\\angle"),
  ps_im({ trig = "degs" }, "^{\\circ}"),
  ps_im({ trig = ":-1" }, " ^{-1}"),
  ps_im({ trig = "ddd" }, "\\frac{\\dd ${1:y}}{\\dd ${2:x}}$0"),
  ps_im({ trig = "dd2" }, "\\frac{\\dd ^2 ${1:y}}{\\dd ${2:x} ^2}$0"),
  ps_im({ trig = "ddx" }, "\\dd x"),
  ps_im({ trig = "ddy" }, "\\dd y"),
  ps_im({ trig = "ddu" }, "\\dd u"),
  ps_im({ trig = "ddt" }, "\\dd t"),
  ps_im({ trig = "ddv" }, "\\dd v"),
  ps_im({ trig = "ddV" }, "\\dd V"),
  ps_im({ trig = "ddr" }, "\\dd r"),
  ps_im({ trig = "+-" }, "\\pm"),
  ps_im({ trig = "e=" }, "&\\equiv $0 \\\\\\\\"),
  ps_im({ trig = "=e" }, "\\equiv $0"),
  ps_im({ trig = "tag" }, "\\tag{$0}"),
  ps_im({ trig = "tg" }, "\\tag*{$0}"),

  -- INSTANT OUTSIDE MATH MODE
  ps_nm({ trig = ":-1" }, "$^{-1}$"),
  ps_nm({ trig = "iii" }, "\\item"),
  ps_nm({ trig = "siii" }, "\\subitem"),

  ps_nm({ trig = ":np" }, "\\newpage %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"),
  ps_nm({ trig = ":qp" }, "\\qpart"),
  ps_nm({ trig = ":qsp" }, "\\qsubpart"),
}
