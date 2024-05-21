---@type MappingsTable
local M = {}

M.general = {
  n = {
    ["H"] = { "^" },
    ["L"] = { "$" },
    ["dH"] = { "d^" },
    ["dL"] = { "d$" },
    ["cH"] = { "c^" },
    ["cL"] = { "c$" },
    ["<C-d>"] = { "21jzz" },
    ["<C-u>"] = { "21kzz" },
    ["<A-h>"] = { "<C-w>h" },
    ["<A-j>"] = { "<C-w>j" },
    ["<A-k>"] = { "<C-w>k" },
    ["<A-l>"] = { "<C-w>l" },
    ["<C-a>"] = { "GVgg" },
    ["zh"] = { "20zh" },
    ["zl"] = { "20zl" },
    ["n"] = { "nzzzv" },
    ["N"] = { "Nzzzv" },
    ["J"] = { "mzJ`z" },
    ["<"] = { "<<", opts = { nowait = true } },
    [">"] = { ">>", opts = { nowait = true } },
    ["<leader>s"] = { ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>" },
    ["<leader>qa"] = { "<cmd>%bd|e#<CR>", "close all buffers except current" },
  },

  i = {
    ["<C-a>"] = { "<ESC> GVgg" },
    ["<C-s>"] = { "<ESC> :w <CR>" },
    ["<C-v>"] = { "<C-r>+" },
    ["<C-CR>"] = { "<End><CR>" },
    ["<S-CR>"] = { "<ESC>O" },
    ["<C-BS>"] = { "<C-w>" },
    ["<A-h>"] = { "<Left>" },
    ["<A-j>"] = { "<Down>" },
    ["<A-k>"] = { "<Up>" },
    ["<A-l>"] = { "<Right>" },
    ["<C-h>"] = { "<Home>" },
    ["<C-l>"] = { "<End>" },
  },

  v = {
    ["H"] = { "^" },
    ["L"] = { "$" },
    ["<C-d>"] = { "21jzz" },
    ["<C-u>"] = { "21kzz" },
    ["<C-h>"] = { "<Home>" },
    ["<C-l>"] = { "<End>" },
    ["<C-a>"] = { "<ESC> GVgg" },
    ["<A-j>"] = { ":m '>+1<CR>gv=gv", "move selection line down" },
    ["<A-k>"] = { ":m '<-2<CR>gv=gv", "move selection line up" },
    ["J"] = { "mzJ`z" },
    ["/"] = { "y /<C-r>+<CR>zz" },
    ["?"] = { "y ?<C-r>+<CR>zz" },
  },

  c = { ["<C-v>"] = { "<C-r>+" } },
}

M.plugins = {
  n = {
    ["<C-S-i>"] = { "<cmd>lua vim.lsp.buf.format { async = true }<CR>", "format files" },
    ["<C-f>"] = { "<cmd> Telescope live_grep <CR>", "open search in all files" },
    ["<C-h>"] = { "<cmd> NvimTreeOpen <CR>" },
    ["<C-b>"] = { "<cmd> NvimTreeToggle <CR>" },
    ["<C-k>"] = { "<cmd>lua require('nvchad.tabufline').tabuflineNext()<CR>" },
    ["<C-j>"] = { "<cmd>lua require('nvchad.tabufline').tabuflinePrev()<CR>" },
    ["<C-q>"] = { "<cmd>lua require('nvchad.tabufline').close_buffer()<CR>" },
    ["<C-/>"] = { "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>" },
    ["<C-`>"] = { "<cmd>lua require('nvterm.terminal').toggle 'float'<CR>" },
    ["<leader>oc"] = { "<cmd>lua require('obsidian').util.toggle_checkbox()<CR>" },
  },
  i = {
    ["<C-/>"] = { "<ESC><cmd>lua require('Comment.api').toggle.linewise.current()<CR> A" },
    ["<C-j>"] = { "<ESC><cmd> bp <CR>", "modern change tab left" },
    ["<C-k>"] = { "<ESC><cmd> bn <CR>", "modern change tab right" },
  },
  v = {
    ["<C-f>"] = { "y <cmd> Telescope live_grep <CR><C-r>+", "search current selection in all files" },
    ["<C-/>"] = { "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>" },
  },
  t = {
    ["<C-`>"] = { "<cmd>lua require('nvterm.terminal').toggle 'float'<CR>" },
  },
}

return M
