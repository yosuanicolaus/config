local directories_format_changed = {
  --- for all directories listed here, auto format only the changed lines by default
  "~/work/odoo",
  "~/work/enterprise",
  "~/work/iap-apps",
  "~/repos/cmp-rpncalc",
}
local directories_format_disable = {
  --- for all directories listed here, disable auto-format by default
}

local function get_default_directory_format()
  for _, dir_format_chg in ipairs(directories_format_changed) do
    if vim.fn.getcwd() == vim.fn.expand(dir_format_chg) then
      return "changed"
    end
  end
  for _, dir_format_chg in ipairs(directories_format_disable) do
    if vim.fn.getcwd() == vim.fn.expand(dir_format_chg) then
      return "disable"
    end
  end
  return ""
end

local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    gdscript = { "gdformat" }, -- [240609] cmd to format using gdtoolkit
    -- css = { "prettier" },
    -- html = { "prettier" },
    tex = { "latexindent" },
    python = { "ruff_fix", "ruff_organize_imports", "ruff_format", lsp_format = "first" },
  },

  formatters = {
    latexindent = {
      command = "latexindent",
      stdin = true,
      append_args = function()
        return { "-m" }
      end,
    },
    ruff_format = {
      append_args = {
        "--line-length",
        "140",
      },
    },
  },

  format_on_save = function(bufnr)
    local buffer_setting = vim.b[bufnr].custom_autoformat_setting
    local global_setting = vim.g.custom_autoformat_setting
    local default_setting = get_default_directory_format()
    local final_setting = "enable"

    if default_setting ~= "" then
      vim.notify("default setting " .. default_setting)
      final_setting = default_setting -- by default: format on save
    end
    if global_setting ~= nil then
      vim.notify("global setting " .. global_setting)
      final_setting = global_setting
    end
    if buffer_setting ~= nil then
      vim.notify("buffer setting " .. buffer_setting)
      final_setting = buffer_setting
    end
    -- print(final_setting)

    if final_setting == "disable" then
      return
    elseif final_setting == "changed" then
      require("helper").format_hunks()
    -- elseif final_setting == "enable" then
    else
      require("conform").format {
        timeout_ms = 500,
        lsp_fallback = true,
      }
    end
    -- vim.notify("all settings is: " .. final_setting .. " and " .. buffer_setting .." and " ..  global_setting .. " and " .. default_setting)
  end,
}

require("conform").setup(options)
