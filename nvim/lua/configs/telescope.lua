-- require("telescope").setup {
-- }

-- update: actually... <C-u> is used for scrolling (along with <C-d>) ...
-- local options = {}

local options = {
  defaults = {
    mappings = {
      i = {
        -- ["<C-u>"] = false, -- allow removing line with <C-u>
      },
    },
  },

  pickers = {
    find_files = {
      push_tagstack_on_edit = true,
    },

    help_tags = {
      mappings = {
        i = {
          ["<CR>"] = "select_vertical", -- open help result in vertical split
        },
      },
    },
  },
}

return vim.tbl_deep_extend("force", require "nvchad.configs.telescope", options)
