-- 241224 manually customize our own nvchad.mappings
-- require "nvchad.mappings"
require "nvchad_mappings"

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
map("n", "zO", "zR")
map("n", "zC", "zM")

map("n", "<leader>h", "<cmd>lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({0}),{0})<CR>")

-- Insert mode
map("i", "<C-v>", "<C-r>+")
map("i", "<C-CR>", "<End><CR>")
map("i", "<C-BS>", "<C-w>")

map("i", "<S-CR>", "<ESC>O")
-- map("i", "<Down>", "<C-n>", { remap = true })
-- map("i", "<Up>", "<C-p>", { remap = true })

-- Visual mode
map("v", "<A-j>", ":m '>+1<CR>gv=gv")
map("v", "<A-k>", ":m '<-2<CR>gv=gv")
map("v", "J", "mzJ`z")
map("v", "/", "y /<C-r>+<CR>zz")
map("v", "?", "y ?<C-r>+<CR>zz")
map("v", "<", "<gv")
map("v", ">", ">gv")
map("v", "p", "pgvy")

-- Other + Multi mode
map("c", "<C-v>", "<C-r>+")
map({ "n", "v" }, "H", "^")
map({ "n", "v" }, "L", "$h")
map({ "n", "v" }, "<C-d>", "<C-d>zz")
map({ "n", "v" }, "<C-u>", "<C-u>zz")
map({ "i", "v" }, "<C-a>", "<ESC>GVgg")
map({ "i", "v" }, "<C-h>", "<Home>")
map({ "i", "v" }, "<C-l>", "<End>")
map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- Plugins
map({ "n", "i", "v" }, "<C-j>", "<cmd>lua require('nvchad.tabufline').prev()<CR>", { desc = "change tab left" })
map({ "n", "i", "v" }, "<C-k>", "<cmd>lua require('nvchad.tabufline').next()<CR>", { desc = "change tab right" })
map({ "n", "i" }, "<C-/>", "<esc>gcc", { desc = "toggle comment", remap = true })
map("v", "<C-/>", "gcgv", { desc = "toggle comment", remap = true })
map("n", "<C-q>", "<cmd> lua require('nvchad.tabufline').close_buffer() <CR>")
map("n", "Q", "<cmd> Bdelete other <CR>", { desc = "close all other tab" })
map("n", "<leader>oc", "<cmd>lua require('obsidian').util.toggle_checkbox() <CR>")

-- Telescope
map("n", "<C-f>", "<cmd> Telescope live_grep <CR>", { desc = "open search in all files" })
map("v", "<C-f>", '"zy <cmd> Telescope live_grep <CR><C-r>z', { desc = "search current selection in all files" })
map("n", "<leader>ft", "")

-- map("n", "<C-b>", "<cmd>NvimTreeToggle<CR>") -- toggle show file explorer

map("n", "<leader>tt", "<cmd>lua require('base46').toggle_transparency()<CR>")

-- Remap to NvChad (nvchad_mappings)
map({ "n", "t" }, "<C-`>", "<A-i>", { remap = true }) -- toggle terminal
-- map("n", "<C-h>", "<leader>e", { remap = true }) -- focus file explorer TODO: if condition check?
map("n", "<C-S-p>", "<leader>ff", { remap = true }) -- search file
map("n", "<C-p>", "<leader>ff", { remap = true }) -- search file

map("n", "gd", "gdzz", { remap = true })

map("n", "<CR>", "<CR><cmd>:cclose<CR>zz")

map("n", "<C-o>", "<C-o>zz", { remap = true })
map("n", "<C-i>", "<C-i>zz", { remap = true })
map("n", "<C-t>", "<C-t>zz", { remap = true })
map("n", "<C-y>", "<cmd> tag! <CR>yy")

map("n", "gh", "<leader>sh", { remap = true }) -- NvChad lspconfig | vim.lsp.buf.signature_help

map("n", "<C-c>", "<C-w>c", { remap = true })
