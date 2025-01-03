local excluded_directories = {
  --- for all directories listed here, auto format only the changed lines
  "~/work/odoo",
  "~/work/enterprise",
}

local function is_in_excluded_directories()
  for _, excluded_dir in ipairs(excluded_directories) do
    if vim.fn.getcwd() == vim.fn.expand(excluded_dir) then
      return true
    end
  end

  return false
end

local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    gdscript = { "gdformat" }, -- [240609] cmd to format using gdtoolkit
    -- css = { "prettier" },
    -- html = { "prettier" },
    tex = { "latexindent" },
  },

  formatters = {
    latexindent = {
      command = "latexindent",
      stdin = true,
      append_args = function()
        return { "-m" }
      end,
    },
  },

  format_on_save = function()
    if is_in_excluded_directories() then
      require("helper").format_hunks()
    else
      require("conform").format {
        timeout_ms = 500,
        lsp_fallback = true,
      }
    end
  end,
}

require("conform").setup(options)
