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
  map("n", "<leader>ra", require "nvchad.lsp.renamer", opts "NvRenamer")

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

  require("lspconfig").lua_ls.setup {
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
  }
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local lspconfig = require "lspconfig"
local servers = {
  "html",
  "cssls",
  "rust_analyzer",
  "pyright",
  "ruff",
  "gdscript",
  "ts_ls",
  "clangd",
  "texlab",
  "svelte",
}

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = M.on_attach,
    on_init = M.on_init,
    capabilities = M.capabilities,
  }
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
--- ODOO LS https://github.com/Whenrow/odoo-ls.nvim/blob/main/lua/odools/init.lua
--- As of 250312, still not working! (the LSP just crash everytime ._.)
--------------------------------------------------------------------------------

local util = {}

util.path_exists = function(file)
  local ok, err, code = os.rename(file, file)
  if not ok then
    if code == 13 then
      -- Permission denied, but it exists
      return true
    end
  end
  return ok, err
end

-- util.get_server_path = function()
--   local bin_dir_path = vim.fn.stdpath "data" .. "/odoo"
--   local bin_path = bin_dir_path .. "/odoo_ls_server"
--   if not util.path_exists(bin_path) then
--     vim.api.nvim_echo({ { "[Odools] You should download the server executable\n" } }, true, {})
--   end
--   return bin_path
-- end

---Get the user config to assert basic values
---@param conf {[string]: string}
util.check_config = function(conf)
  if not conf then
    vim.api.nvim_echo({ { "You should give a minimal configuration" } }, true, { err = true })
  end
  if not conf.odoo_path or type(conf.odoo_path) ~= "string" or not util.path_exists(conf.odoo_path) then
    vim.api.nvim_echo({ { "You should give a valid odoo path" } }, true, { err = true })
  end
  if not conf.python_path or type(conf.python_path) ~= "string" or not util.path_exists(conf.python_path) then
    vim.api.nvim_echo({ { "You should give a valid python path" } }, true, { err = true })
  end
  if not conf.server_path or type(conf.server_path) ~= "string" or not util.path_exists(conf.server_path) then
    vim.api.nvim_echo({ { "You should give a valid server path or download it" } }, true, { err = true })
  end
end

local lsp_config = require "lspconfig.configs"

if not lsp_config then
  vim.api.nvim_echo({ { "lsp_config not available" } }, true, { err = true })
  return
end

local h = os.getenv "HOME"
local opt = {
  -- mandatory
  odoo_path = h .. "/work/odoo/",
  python_path = "/usr/bin/python3",
  server_path = h .. "/.local/bin/odoo_ls_server",
  -- optional
  addons = { h .. "/work/enterprise/" },
  additional_stubs = { h .. "/repos/typeshed/stubs/" },
  root = h .. "/work/", -- working directory, odoo_path if empty
  settings = {
    autoRefresh = true,
    autoRefreshDelay = nil,
    diagMissingImportLevel = "none",
  },
}

opt.python_path = opt.python_path or "/usr/bin/python3"
util.check_config(opt)
local odoo_path = opt.odoo_path
opt.root = opt.root or odoo_path
local odooConfig = {
  id = 1,
  name = "main config",
  validatedAddonsPaths = opt.addons or {},
  addons = opt.addons or {},
  odooPath = odoo_path,
  finalPythonPath = opt.python_path,
  additional_stubs = opt.additional_stubs or {},
}
lsp_config.odools = {
  default_config = {
    name = "odools",
    cmd = { h .. "/.local/bin/odoo_ls_server" },
    root = function()
      return vim.fn.fnamemodify(h .. "/.local/bin/odoo_ls_server", ":h")
    end,
    workspace_folders = {
      {
        uri = function()
          return opt.root
        end,
        name = function()
          return "base_workspace"
        end,
      },
    },
    filetypes = { "python" },
    settings = {
      Odoo = {
        autoRefresh = opt.settings and opt.settings.autoRefresh or true,
        autoRefreshDelay = opt.settings and opt.settings.autoRefreshDelay or nil,
        diagMissingImportLevel = opt.settings and opt.settings.diagMissingImportLevel or "none",
        configurations = { mainConfig = odooConfig },
        selectedConfiguration = "mainConfig",
      },
    },
    capabilities = {
      textDocument = {
        workspace = {
          symbol = {
            dynamicRegistration = true,
          },
        },
      },
    },
  },
}
lsp_config.odools.setup {}

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

return M
