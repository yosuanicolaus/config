dofile(vim.g.base46_cache .. "mason")

return {
  PATH = "skip",

  ui = {
    icons = {
      package_pending = " ",
      package_installed = " ",
      package_uninstalled = " ",
    },
  },

  ensure_installed = {
    "lua-language-server",
    "bash-language-server",
    "markdown-oxide",
    "rust-analyzer",
    "basedpyright",
    "html-lsp",
    "css-lsp",
    "harper-ls",
    "stylua",
    "prettier",
    "ast-grep",
    "gdtoolkit",
    "ruff",
  },

  max_concurrent_installers = 10,
}
