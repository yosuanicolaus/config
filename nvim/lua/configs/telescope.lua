local options = {
  defaults = {
    mappings = {
      i = {
        ["<C-u>"] = false, -- allow removing line with <C-u>
      },
    },
  },
}

return vim.tbl_deep_extend("force", require "nvchad.configs.telescope", options)
