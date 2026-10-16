local M = {}
local map = vim.keymap.set

-- export on_attach & capabilities
M.on_attach = function(_, bufnr)
  local function opts(desc)
    return { buffer = bufnr, desc = "LSP " .. desc }
  end

  map("n", "gD", vim.lsp.buf.declaration, opts "Go to declaration")
  map("n", "gd", vim.lsp.buf.definition, opts "Go to definition")
  map("n", "gi", vim.lsp.buf.implementation, opts "Go to implementation")
  map("n", "<leader>sh", vim.lsp.buf.signature_help, opts "Show signature help")
  map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts "Add workspace folder")
  map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts "Remove workspace folder")

  map("n", "<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, opts "List workspace folders")

  map("n", "<leader>D", vim.lsp.buf.type_definition, opts "Go to type definition")
  map({ "n", "v" }, "<leader>ra", require "nvchad.lsp.renamer", opts "NvRenamer")
  map({ "n", "v" }, "<F2>", "<leader>ra", { remap = true })

  map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts "Code action")
  map("n", "gr", vim.lsp.buf.references, opts "Show references")
end

-- disable semanticTokens
M.on_init = function(client, _)
  if client.supports_method "textDocument/semanticTokens" then
    client.server_capabilities.semanticTokensProvider = nil
  end
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()

M.capabilities.textDocument.completion.completionItem = {
  documentationFormat = { "markdown", "plaintext" },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  },
}

M.defaults = function()
  dofile(vim.g.base46_cache .. "lsp")
  require("nvchad.lsp").diagnostic_config()

  vim.lsp.config("lua_ls", {
    on_attach = M.on_attach,
    capabilities = M.capabilities,
    on_init = M.on_init,

    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" },
        },
        workspace = {
          library = {
            vim.fn.expand "$VIMRUNTIME/lua",
            vim.fn.expand "$VIMRUNTIME/lua/vim/lsp",
            vim.fn.stdpath "data" .. "/lazy/ui/nvchad_types",
            vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy",
            "${3rd}/luv/library",
          },
          maxPreload = 100000,
          preloadFileSize = 10000,
        },
      },
    },
  })
  vim.lsp.enable "lua_ls"
end

--------------------------------------------------------------------------------

-- Resolve the python interpreter for uv / venv projects.
-- Pyright defaults to system python, so `from laya import ...` fails
-- even though the package exists in `<project>/.venv`.
local function resolve_project_python(workspace)
  -- 1. Already-activated venv (e.g. `source .venv/bin/activate`)
  if vim.env.VIRTUAL_ENV and vim.fn.executable(vim.env.VIRTUAL_ENV .. "/bin/python") == 1 then
    return vim.env.VIRTUAL_ENV .. "/bin/python"
  end

  -- 2. Walk up from the workspace root looking for uv/venv layouts
  local dir = workspace and vim.fn.fnamemodify(workspace, ":p:h") or vim.fn.getcwd()
  while dir and dir ~= "" do
    for _, candidate in ipairs {
      vim.fs.joinpath(dir, ".venv", "bin", "python"),
      vim.fs.joinpath(dir, "venv", "bin", "python"),
      vim.fs.joinpath(dir, ".venv", "Scripts", "python.exe"),
    } do
      if vim.fn.executable(candidate) == 1 then
        return candidate
      end
    end
    local parent = vim.fn.fnamemodify(dir, ":h")
    if not parent or parent == dir then
      break
    end
    dir = parent
  end

  return vim.fn.exepath "python3" ~= "" and vim.fn.exepath "python3" or "python3"
end

vim.lsp.config("pyright", {
  on_attach = M.on_attach,
  on_init = M.on_init,
  capabilities = M.capabilities,
  before_init = function(_, config)
    local workspace = config.root_dir or vim.fn.getcwd()
    local python = resolve_project_python(workspace)
    config.settings = config.settings or {}
    config.settings.python = config.settings.python or {}
    -- Only set a default; respect explicit pyrightconfig.json / settings
    if not config.settings.python.pythonPath then
      config.settings.python.pythonPath = python
    end
  end,
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
      },
    },
  },
})
vim.lsp.enable "pyright"

local servers = {
  "html",
  "cssls",
  "rust_analyzer",
  "ruff",
  "gdscript",
  "ts_ls",
  "clangd",
  "texlab",
  "svelte",
}

-- lsps with default config
for _, lsp in ipairs(servers) do
  vim.lsp.config(lsp, {
    on_attach = M.on_attach,
    on_init = M.on_init,
    capabilities = M.capabilities,
  })
  vim.lsp.enable(lsp)
end

return M
