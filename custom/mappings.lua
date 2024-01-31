---@type MappingsTable
local M = {}

M.general = {
  n = {
    ["<C-a>"] = { "GVgg" },
    ["<C-d>"] = { "<C-d>zz" },
    ["<C-u>"] = { "<C-u>zz" },
    ["<"] = { "<<", opts = { nowait = true } },
    [">"] = { ">>", opts = { nowait = true } },
    ["zh"] = { "20zh" },
    ["zl"] = { "20zl" },
    ["n"] = { "nzzzv" },
    ["N"] = { "Nzzzv" },
    ["J"] = { "mzJ`z" },
    ["<leader>s"] = { ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>" },
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
    ["<C-a>"] = { "<ESC> GVgg", "select all" },
    ["<C-d>"] = { "<C-d>zz" },
    ["<C-u>"] = { "<C-u>zz" },
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
    ["<C-w>"] = { "<cmd>lua require('nvchad.tabufline').close_buffer()<CR>" },
    ["<C-/>"] = { "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>" },
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
}

return M
