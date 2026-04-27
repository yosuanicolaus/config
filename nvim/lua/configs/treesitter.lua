pcall(function()
  dofile(vim.g.base46_cache .. "syntax")
  dofile(vim.g.base46_cache .. "treesitter")
end)

return {
  ensure_installed = {
    "bash",
    "css",
    "gdscript",
    "gdshader",
    "godot_resource",
    "html",
    "lua",
    "luadoc",
    "printf",
    "python",
    "rust",
    "vim",
    "vimdoc",
    "markdown",
  },

  highlight = {
    enable = true,
    disable = { "latex" },
    additional_vim_regex_highlighting = { "latex", "markdown" },
  },

  indent = { enable = true },
}
