-- local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })

vim.opt.relativenumber = true
vim.o.linebreak = true

-- 2024-02-04 for obsidian.nvim
if vim.fn.getcwd() == '/home/yosuanicolaus/codes/obsidian' then
  vim.opt_local.conceallevel = 1
  vim.o.textwidth = 80
  vim.o.wrap = true
end

-- 2023-08-02
if vim.o.termguicolors == "kitty" then
  vim.o.termguicolors = true
end
