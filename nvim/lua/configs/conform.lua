local directories_format_changed = {
  --- for all directories listed here, auto format only the changed lines
  "~/work/odoo",
  "~/work/enterprise",
  "~/work/iap-apps",
}

local function is_in_directories_format_changed()
  for _, dir_format_chg in ipairs(directories_format_changed) do
    if vim.fn.getcwd() == vim.fn.expand(dir_format_chg) then
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
    if vim.g.custom_autoformat_disable or vim.b[bufnr].custom_autoformat_disable then
      return
    elseif
      vim.g.custom_autoformat_changed
      or vim.b[bufnr].custom_autoformat_changed
      or is_in_directories_format_changed()
    then
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
