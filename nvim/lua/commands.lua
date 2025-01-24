-- 241226 better "checkhealth" (don't create new tabs!)
-- replace "checkhealth" automatically (when typing "che" / "checkhealth")
-- also for when running LspInfo (modern alias for checkhealth)
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

-- For temporary disable/only-changed/enable autoformat
-- See conform.lua - format_on_save function for more details

vim.api.nvim_create_user_command("FormatDisable", function()
  vim.b.custom_autoformat_disable = true
end, {
  desc = "Disable autoformat-on-save on current file",
})

vim.api.nvim_create_user_command("FormatDisableAll", function()
  vim.g.custom_autoformat_disable = true
end, {
  desc = "Disable autoformat-on-save on all file",
})

vim.api.nvim_create_user_command("FormatChanged", function()
  vim.b.custom_autoformat_changed = true
end, {
  desc = "Only autoformat-on-save on changed lines for the current file",
})

vim.api.nvim_create_user_command("FormatChangedAll", function()
  vim.g.custom_autoformat_changed = true
end, {
  desc = "Only autoformat-on-save on changed lines on all file",
})

vim.api.nvim_create_user_command("FormatEnable", function()
  vim.b.custom_autoformat_disable = false
  vim.g.custom_autoformat_disable = false
  vim.b.custom_autoformat_changed = false
  vim.g.custom_autoformat_changed = false
end, {
  desc = "Re-enable autoformat-on-save",
})
