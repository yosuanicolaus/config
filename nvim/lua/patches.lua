-- Patches for snacks.nvim image (internals: may break on plugin updates)
vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    local ok_i, inline = pcall(require, "snacks.image.inline")
    local ok_p, placement = pcall(require, "snacks.image.placement")
    if not (ok_i and ok_p) then
      return
    end

    -- 1. Don't re-render while typing; catch up on InsertLeave
    local orig_update = inline.update
    inline.update = function(self, ...)
      local m = vim.api.nvim_get_mode().mode:sub(1, 1)
      if m == "i" or m == "R" then
        return
      end
      return orig_update(self, ...)
    end
    vim.api.nvim_create_autocmd("InsertLeave", {
      callback = function(ev)
        pcall(vim.api.nvim_exec_autocmds, "WinScrolled", {
          group = "snacks.image.inline." .. ev.buf,
          buffer = ev.buf,
          modeline = false,
        })
      end,
    })

    -- 2. Only reveal the source when the cursor is ON the equation (not the line above)
    inline.conceal = function(self)
      local mode = vim.fn.mode():sub(1, 1):lower()
      for _, img in pairs(self.imgs) do
        img:show()
      end
      if vim.wo.concealcursor:find(mode) then
        return
      end
      local from, to = vim.fn.line "v", vim.fn.line "."
      from, to = math.min(from, to), math.max(from, to)
      for _, img in pairs(self:get(from, to - 1)) do
        if img.opts.conceal then
          img:hide()
        end
      end
    end

    -- 3. Size to the real text width (no clipping) and cap \includegraphics pictures
    local PICTURE_MAX = { w = 40, h = 15 } -- cells; set to nil to disable the cap
    local orig_state = placement.state
    placement.state = function(self)
      local avail = vim.o.columns
      for _, win in ipairs(self:wins()) do
        local info = vim.fn.getwininfo(win)[1]
        avail = math.min(avail, info.width - info.textoff)
      end
      self._base = self._base or { w = self.opts.max_width, h = self.opts.max_height }
      local w, h = self._base.w, self._base.h
      if PICTURE_MAX and self.opts.type == "image" then
        w, h = PICTURE_MAX.w, PICTURE_MAX.h
      end
      self.opts.max_width = math.min(w or math.huge, avail)
      self.opts.max_height = h
      return orig_state(self)
    end
  end,
})
