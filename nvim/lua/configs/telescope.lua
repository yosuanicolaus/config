local actions = require "telescope.actions"

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

    live_grep = {
      mappings = {
        -- center screen to cursor ("zz") after opening the result
        i = {
          ["<CR>"] = actions.select_default + actions.center,
          ["<S-CR>"] = actions.select_vertical + actions.center,
        },
        n = {
          ["<CR>"] = actions.select_default + actions.center,
          ["<S-CR>"] = actions.select_vertical + actions.center,
        },
      },
    },

    help_tags = {
      mappings = {
        i = {
          ["<CR>"] = actions.select_vertical, -- open help result in vertical split
        },
      },
    },
  },
}

return vim.tbl_deep_extend("force", require "nvchad.configs.telescope", options)
