require "nvchad.mappings"

local map = vim.keymap.set

-- Normal mode
map("n", "dH", "d^")
map("n", "dL", "d$")
map("n", "cH", "c^")
map("n", "cL", "c$")

map("n", "<A-h>", "<C-w>h")
map("n", "<A-j>", "<C-w>j")
map("n", "<A-k>", "<C-w>k")
map("n", "<A-l>", "<C-w>l")
map("n", "<C-a>", "GVgg")
map("n", "zh", "20zh")
map("n", "zl", "20zl")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")
map("n", "J", "mzJ`z")
map("n", "<", "<<", { nowait = true })
map("n", ">", ">>", { nowait = true })

-- Insert mode
map("i", "<C-v>", "<C-r>+")
map("i", "<C-CR>", "<End><CR>")
map("i", "<A-h>", "<Left>")
map("i", "<C-BS>", "<C-w>")
map("i", "<A-h>", "<Left>")
map("i", "<A-j>", "<Down>")
map("i", "<A-k>", "<Up>")
map("i", "<A-l>", "<Right>")

-- Visual mode
map("v", "<A-j>", ":m '>+1<CR>gv=gv")
map("v", "<A-k>", ":m '<-2<CR>gv=gv")
map("v", "J", "mzJ`z")
map("v", "/", "y /<C-r>+<CR>zz")
map("v", "?", "y ?<C-r>+<CR>zz")
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Other + Multi mode
map("c", "<C-v>", "<C-r>+")
map({ "n", "v" }, "H", "^")
map({ "n", "v" }, "L", "$")
map({ "n", "v" }, "<C-d>", "<C-d>zz")
map({ "n", "v" }, "<C-u>", "<C-u>zz")
map({ "i", "v" }, "<C-a>", "<ESC>GVgg")
map({ "i", "v" }, "<C-h>", "<Home>")
map({ "i", "v" }, "<C-l>", "<End>")
map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- Plugins
map({ "n", "i", "v" }, "<C-j>", "<cmd>bp<cr>", { desc = "change tab left" })
map({ "n", "i", "v" }, "<C-k>", "<cmd>bn<cr>", { desc = "change tab right" })
map({ "n", "i" }, "<C-/>", "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>")
map("v", "<C-/>", "<esc>gv<cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>")
map("n", "<C-f>", "<cmd> Telescope live_grep <CR>", { desc = "open search in all files" })
map("n", "<C-q>", "<cmd>lua require('nvchad.tabufline').close_buffer()<CR>")
map("n", "<leader>oc", "<cmd>lua require('obsidian').util.toggle_checkbox()<CR>")
map("v", "<C-f>", "y <cmd> Telescope live_grep <CR><C-r>+", { desc = "search current selection in all files" })

-- Remap to NvChad
map({ "n", "t" }, "<C-`>", "<A-i>", { remap = true }) -- toggle terminal
map("n", "<C-h>", "<leader>e", { remap = true }) -- focus file explorer
map("n", "<C-b>", "<C-n>", { remap = true }) -- toggle show file explorer
