local null_ls = require "null-ls"

local b = null_ls.builtins

local sources = {

  -- webdev stuff
  b.formatting.deno_fmt, -- choosed deno for ts/js files cuz its very fast!
  b.formatting.prettier.with { filetypes = { "html", "markdown", "css" } }, -- so prettier works only on these filetypes

  -- Lua
  b.formatting.stylua,

  -- cpp
  b.formatting.clang_format,

  -- rust (2300423)
  b.formatting.rustfmt,

  -- python (230512)
  b.formatting.autopep8,

  -- for .zshrc [2023-11-15]
  b.formatting.beautysh,
}

-- 230423 format on save -> 2023-09-07 DON'T format on save
-- https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Formatting-on-save
--
-- local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
-- null_ls.setup {
--   debug = true,
--   sources = sources,
--   on_attach = function(client, bufnr)
--     if client.supports_method "textDocument/formatting" then
--       vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
--       vim.api.nvim_create_autocmd("BufWritePre", {
--         group = augroup,
--         buffer = bufnr,
--         callback = function()
--           vim.lsp.buf.format { bufnr = bufnr }
--         end,
--       })
--     end
--   end,
-- }

null_ls.setup {
  debug = true,
  sources = sources,
}
