require "nvchad.options"

-- add yours here!

local o = vim.opt
o.cursorlineopt = "both" -- to enable cursorline!

---------------------------------------------------------

-- 240522 convert nvchad to 2.5
o.relativenumber = true
o.linebreak = true

-- 241211 enable inlay hint by default
vim.lsp.inlay_hint.enable()

-- 2024-02-04 for obsidian.nvim
if vim.fn.getcwd() == "/home/yosuanicolaus/codes/obsidian" then
  vim.opt_local.conceallevel = 1
  o.conceallevel = 1
  o.textwidth = 80
  o.wrap = true
end

-- 2023-08-02
if o.termguicolors == "kitty" then
  o.termguicolors = true
end

-- 240825 Neovide
if vim.g.neovide then
  vim.o.guifont = "JetBrainsMono Nerd Font Mono:h10"
  vim.g.neovide_scroll_animation_length = 0
  vim.g.neovide_cursor_animation_length = 0
  -- vim.g.neovide_transparency = 0.9
end

-- 240609 for godot
-- local projectfile = vim.fn.getcwd() .. "/project.godot"
-- if projectfile then
--   vim.fn.serverstart "./godothost"
-- end
