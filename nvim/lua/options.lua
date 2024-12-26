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

-- 241221 allow reopening closed buffer with C-o (last cursor position)
o.jumpoptions:remove "clean"

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

-- 241226 better "checkhealth" (don't create new tabs!)
-- replace "checkhealth" automatically (when typing "che" / "checkhealth")
vim.api.nvim_create_user_command("Checkhealth", function(args)
  local cmd = "vert checkhealth " .. args.args
  vim.cmd(cmd)
  vim.opt_local.bufhidden = "wipe"
  vim.opt_local.modifiable = false
  vim.opt_local.buflisted = false
  vim.opt_local.swapfile = false
  vim.opt_local.cursorline = false
  vim.opt_local.cursorcolumn = false
  vim.opt_local.number = false
  vim.opt_local.relativenumber = false
  vim.opt_local.ruler = false
  vim.opt_local.list = false
  vim.opt_local.showmode = false
  vim.opt_local.showcmd = false
  vim.cmd("file " .. args.args .. "\\ health")
end, {
  nargs = "?",
  complete = "checkhealth",
})

vim.cmd [[cnoreabbrev <expr> checkhealth getcmdtype() == ":" && getcmdline() == 'checkhealth' ? 'Checkhealth' : 'checkhealth']]
vim.cmd [[cnoreabbrev <expr> che getcmdtype() == ":" && getcmdline() == 'che' ? 'Checkhealth' : 'che']]
vim.cmd [[cnoreabbrev <expr> LspInfo getcmdtype() == ":" && getcmdline() == 'LspInfo' ? 'Checkhealth lspconfig' :'LspInfo']]
