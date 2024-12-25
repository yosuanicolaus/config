local nvchad_cmp = require "nvchad.configs.cmp"
local cmp = require "cmp"

nvchad_cmp.mapping["<Down>"] = cmp.mapping.select_next_item()
nvchad_cmp.mapping["<Up>"] = cmp.mapping.select_prev_item()
nvchad_cmp.mapping["<Tab>"] = nil
nvchad_cmp.mapping["<S-Tab>"] = nil

return nvchad_cmp
