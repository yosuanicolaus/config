local opt = vim.opt
local o = vim.o
local g = vim.g

-------------------------------------- options ------------------------------------------
o.laststatus = 3
o.showmode = false

o.clipboard = "unnamedplus"
o.cursorline = true
o.cursorlineopt = "number"

-- Indenting
o.expandtab = true
o.shiftwidth = 2
o.smartindent = true
o.tabstop = 2
o.softtabstop = 2

opt.fillchars = { eob = " " }
o.ignorecase = true
o.smartcase = true
o.mouse = "a"

-- Numbers
o.number = true
o.numberwidth = 2
o.ruler = false

-- disable nvim intro
opt.shortmess:append "sI"

o.signcolumn = "yes"
o.splitbelow = true
o.splitright = true
o.timeoutlen = 400
o.undofile = true

-- interval for writing swap file to disk, also used by gitsigns
o.updatetime = 250

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
opt.whichwrap:append "<>[]hl"

-- disable some default providers
g.loaded_node_provider = 0
g.loaded_python3_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0

-- add binaries installed by mason.nvim to path
local is_windows = vim.fn.has "win32" ~= 0
local sep = is_windows and "\\" or "/"
local delim = is_windows and ";" or ":"
vim.env.PATH = table.concat({ vim.fn.stdpath "data", "mason", "bin" }, sep) .. delim .. vim.env.PATH

-- add yours here!

o.cursorlineopt = "both" -- to enable cursorline!

---------------------------------------------------------

-- 240522 convert nvchad to 2.5
o.relativenumber = true
o.linebreak = true

-- 241211 enable inlay hint by default
vim.lsp.inlay_hint.enable()

-- 241221 allow reopening closed buffer with C-o (last cursor position)
o.jumpoptions = "stack,view"

o.scroll = 0

o.wrap = false

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
  o.guifont = "JetBrainsMono Nerd Font Mono:h9"
  g.neovide_scroll_animation_length = 0
  g.neovide_cursor_animation_length = 0
  -- vim.g.neovide_transparency = 0.9
end

-- 250729 detect *.sch filetype as xml files
vim.filetype.add {
  extension = {
    sch = "xml",
  },
}

------------------------------------------------------------------------

-- 240609 for godot | Update 250518 https://simondalvai.org/blog/godot-neovim
-- paths to check for project.godot file
local paths_to_check = { "/", "/../" }
local is_godot_project = false
local godot_project_path = ""
local cwd = vim.fn.getcwd()
-- iterate over paths and check
for key, value in pairs(paths_to_check) do
  if vim.uv.fs_stat(cwd .. value .. "project.godot") then
    is_godot_project = true
    godot_project_path = cwd .. value
    break
  end
end
-- check if server is already running in godot project path
local is_server_running = vim.uv.fs_stat(godot_project_path .. "/server.pipe")
-- start server, if not already running
if is_godot_project and not is_server_running then
  vim.fn.serverstart(godot_project_path .. "/server.pipe")
end
--- OLD configuration
-- local projectfile = vim.fn.getcwd() .. "/project.godot"
-- if projectfile then
--   vim.fn.serverstart "./godothost"
-- end
------------------------------------------------------------------------
