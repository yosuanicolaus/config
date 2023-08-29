---@type MappingsTable
local M = {}

M.general = {
  -- x = {
  -- somehow it already works here?
  --   ["<leader>p"] = { '"_dP' },
  -- },

  n = {
    ["<C-a>"] = { "GVgg", "select all" },
    ["<C-f>"] = { "<cmd> Telescope live_grep <CR>", "open search in all files" },

    ["J"] = { "mzJ`z" },
    ["n"] = { "nzzzv" },
    ["N"] = { "Nzzzv" },
    ["<leader>s"] = { ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>" },
  },

  i = {
    ["<C-s>"] = { "<ESC> :w <CR>" },
    ["jk"] = { "<ESC>", "escape insert mode", opts = { nowait = true } },
    ["<C-v>"] = { "<C-r>+", "paste" },
    ["<C-CR>"] = { "<End><CR>", "enter to new line" },
    ["<S-CR>"] = { "<ESC>O", "enter to new line before" },

    -- navigation within insert mode
    ["<A-h>"] = { "<Left>", "move left" },
    ["<A-l>"] = { "<Right>", "move right" },
    ["<A-j>"] = { "<Down>", "move down" },
    ["<A-k>"] = { "<Up>", "move up" },
    ["<A-C-h>"] = { "<C-Left>", "move left" },
    ["<A-C-l>"] = { "<C-Right>", "move right" },

    ["<C-h>"] = { "<Home>", "go to beginning of line" },
    ["<C-l>"] = { "<End>", "go to end of line" },

    ["<C-j>"] = { "<ESC><cmd> bp <CR>", "modern change tab left" },
    ["<C-k>"] = { "<ESC><cmd> bn <CR>", "modern change tab right" },
  },

  v = {
    ["<C-f>"] = { "y <cmd> Telescope live_grep <CR><C-r>+", "search in all files the current selection" },
    ["/"] = { "y /<C-r>+<CR>zz" },

    ["<A-j>"] = { ":m '>+1<CR>gv=gv", "move selection line down" },
    ["<A-k>"] = { ":m '<-2<CR>gv=gv", "move selection line up" },

    ["J"] = { "mzJ`z" },
    ["<C-d>"] = { "<C-d>zz" },
    ["<C-u>"] = { "<C-u>zz" },
  },

  c = {
    ["<C-v>"] = { "<C-r>+", "paste" },
  },
}

M.tabufline = {
  plugin = true,
  n = {
    ["<C-k>"] = {
      function()
        require("nvchad_ui.tabufline").tabuflineNext()
      end,
      "goto next buffer",
    },
    ["<C-j>"] = {
      function()
        require("nvchad_ui.tabufline").tabuflinePrev()
      end,
      "goto prev buffer",
    },
    ["<C-w>"] = {
      function()
        require("nvchad_ui.tabufline").close_buffer()
      end,
      "close buffer",
    },
  },
}

M.comment = {
  n = {
    ["<C-/>"] = { "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>", "toggle comment" },
  },
  i = {
    ["<C-/>"] = { "<ESC><cmd>lua require('Comment.api').toggle.linewise.current()<CR> A", "toggle comment" },
  },
  v = {
    ["<C-/>"] = { "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", "toggle comment" },
  },
}

M.nvimtree = {
  n = {
    ["<C-b>"] = { "<cmd> NvimTreeToggle <CR>", "toggle nvimtree" }, -- vscode similarization
  },
}

return M
