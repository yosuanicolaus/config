local o = vim.o
local g = vim.g

-- o.conceallevel = 1

g.vimtex_view_method = "zathura"
-- g.tex_flavor = "latex"
-- g.vimtex_quickfix_mode = 0
-- g.tex_conceal = "abdmg"
--

vim.keymap.set("i", "<C-S-CR>", "<ESC>A \\\\<CR>")
