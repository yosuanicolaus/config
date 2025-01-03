local ls = require "luasnip"
local utils = require "luasnip-latex-snippets.util.utils"
local conds = require "luasnip.extras.expand_conditions"
local pipe = utils.pipe
local t = ls.text_node
local i = ls.insert_node

-- Custom AutoSnippets outside Math Mode

require("luasnip-latex-snippets.wA").retrieve = function(not_math)
  local ps_nm = ls.extend_decorator.apply(ls.parser.parse_snippet, { condition = pipe { not_math } }) --[[@as function]]
  local ps_lb_nm =
    ls.extend_decorator.apply(ls.parser.parse_snippet, { condition = pipe { conds.line_begin, not_math } }) --[[@as function]]
  local s_lb_nm = ls.extend_decorator.apply(ls.snippet, { condition = pipe { conds.line_begin, not_math } }) --[[@as function]]

  return {
    ps_nm({ trig = "mk", name = "Math" }, "\\( ${1:${TM_SELECTED_TEXT}} \\)$0"),
    ps_nm({ trig = "dm", name = "Block Math" }, "\\[\n\t${1:${TM_SELECTED_TEXT}}\n\\] $0"), -- remove "." at the end
    s_lb_nm({ trig = "ali", name = "Align" }, { t { "\\begin{align*}", "\t" }, i(1), t { "", "\\end{align*}" } }), -- remove "." at the end

    ps_lb_nm(
      { trig = "templ", name = "default template" },
      "\\documentclass[a4paper,12pt]{article}\n\\input{../template/default.tex}\n\\title{${1:Lecture Note}}\n\\begin{document}\n\\maketitle\n\n${2:Hello, world!}\n\n\\end{document}"
    ),

    ps_lb_nm({ trig = "hr", name = "line break" }, "\\noindent\\rule{\\textwidth}{1pt}\n$1"),
  }
end

local previous_math_iA_retrieve = require("luasnip-latex-snippets.math_iA").retrieve

--- Custom AutoSnippets inside Math Mode ---

require("luasnip-latex-snippets.math_iA").retrieve = function(is_math)
  local ps_im = ls.extend_decorator.apply(ls.parser.parse_snippet, { condition = pipe { is_math } }) --[[@as function]]

  local custom = {
    ps_im({ trig = "binom" }, "\\binom{$1}{$2} $3"),
    ps_im(
      { trig = "cases" },
      "\\begin{cases}\n\t${1:case_1} & ${2:cond_1} \\\\\\ \n\t${3:case_2} & ${4:cond_2} \\\\\\ \n\\end{cases}"
    ),

    ps_im({ trig = "sum", priority = 1 }, "\\sum_{${1:k=0}}^{${2:\\infty}} $3"),
    ps_im({ trig = "mbf" }, "\\mathbf{${1:R}}$2"),
    ps_im({ trig = "mbb" }, "\\mathbb{${1:R}}$2"),
  }

  return vim.list_extend(previous_math_iA_retrieve(is_math), custom)
end
