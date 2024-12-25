require("telescope").setup {
  pickers = {
    find_files = {
      push_tagstack_on_edit = true,
    },
  },
}

-- update: actually... <C-u> is used for scrolling (along with <C-d>) ...
-- local options = {}

local options = {
  defaults = {
    mappings = {
      i = {
        -- ["<C-u>"] = false, -- allow removing line with <C-u>
        ["<CR>"] = "select_vertical", -- open result in vertical split
      },
    },
  },
}

return vim.tbl_deep_extend("force", require "nvchad.configs.telescope", options)
