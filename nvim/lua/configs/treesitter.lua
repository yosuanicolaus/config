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
  },

  highlight = {
    enable = true,
    use_languagetree = true,
  },

  indent = { enable = true },
}
