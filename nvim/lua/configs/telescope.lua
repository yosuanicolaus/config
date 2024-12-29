dofile(vim.g.base46_cache .. "telescope")

local actions = require "telescope.actions"

return {
  defaults = {
    prompt_prefix = "   ",
    selection_caret = " ",
    entry_prefix = " ",
    sorting_strategy = "ascending",
    layout_config = {
      horizontal = {
        prompt_position = "top",
        preview_width = 0.55,
      },
      width = 0.87,
      height = 0.80,
    },
    mappings = {
      n = { ["q"] = require("telescope.actions").close },
    },
  },

  extensions_list = { "themes", "terms" },
  extensions = {},

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
