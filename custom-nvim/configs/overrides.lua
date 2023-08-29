local M = {}

M.treesitter = {
  ensure_installed = {
    "vim",
    "lua",
    "html",
    "css",
    "javascript",
    "typescript",
    "tsx",
    "c",
    "markdown",
    "markdown_inline",
    "gdscript",
  },
  indent = {
    enable = true,
    disable = {
      "python",
      "gdscript",
    },
  },
}

M.mason = {
  ensure_installed = {
    -- lua stuff
    "lua-language-server",
    "stylua",

    -- web dev stuff
    "css-lsp",
    "html-lsp",
    "typescript-language-server",
    "deno",
    "prettier",

    -- c/cpp stuff
    "clangd",
    "clang-format",

    -- 230423
    "rust-analyzer",
    -- 230512
    "pyright",
    -- 2023-08-05
    "gdtoolkit",
  },
}

-- git support in nvimtree
M.nvimtree = {
  git = {
    enable = true,
  },

  -- 230502 - add relative number for easier navigation
  view = {
    number = true,
    relativenumber = true,
  },

  renderer = {
    highlight_git = true,
    icons = {
      show = {
        git = true,
      },
    },
  },
}

return M
