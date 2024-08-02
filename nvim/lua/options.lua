require "nvchad.options"

-- add yours here!

local o = vim.opt
o.cursorlineopt = "both" -- to enable cursorline!

---------------------------------------------------------

-- 240522 convert nvchad to 2.5
o.relativenumber = true
o.linebreak = true

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

-- 240609 for godot
-- local projectfile = vim.fn.getcwd() .. "/project.godot"
-- if projectfile then
--   vim.fn.serverstart "./godothost"
-- end
