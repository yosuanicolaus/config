local map = vim.keymap.set

----------------------------------------------------------------------------------
---*[ NORMAL MODE ]*--------------------------------------------------------------
----------------------------------------------------------------------------------

-- windows navigation | skip <C-w> for moving & deleting
map("n", "<C-h>", "<C-w>h", { desc = "switch window left" })
map("n", "<C-l>", "<C-w>l", { desc = "switch window right" })
map("n", "<C-j>", "<C-w>j", { desc = "switch window down" })
map("n", "<C-k>", "<C-w>k", { desc = "switch window up" })
map("n", "<C-c>", "<C-w>c", { desc = "close window" })

-- action to beginning/end of the line with "H" & "L"
map("n", "H", "^")
map("n", "L", "$")
map("n", "dH", "d^")
map("n", "dL", "d$")
map("n", "cH", "c^")
map("n", "cL", "c$")
map("n", "D", "cc<ESC>")

-- automatically recenter ("zz") after navigating
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")
map("n", "gd", "gdzz")
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "<C-o>", "<C-o>zz")
map("n", "<C-i>", "<C-i>zz")
map("n", "<C-t>", "<C-t>zz")
map("n", "<CR>", "<CR><CMD>:cclose<CR>zz") -- automatically close quickfix window (after "gd")
map("n", "<S-CR>", "kzz")

-- better/faster indenting
map("n", "<", "<<", { nowait = true })
map("n", ">", ">>", { nowait = true })
map("n", "J", "mzJ`z") -- save cursor position after joining lines

-- "z" commands: scroll horizontal faster | open/fold
map("n", "zh", "20zh")
map("n", "zl", "20zl")
map("n", "zO", "zR")
map("n", "zC", "zM")

-- generalization | quality of life essentials
map("n", "<C-a>", "GVgg", { desc = "general select all" })
map("n", "<C-s>", "<CMD>w<CR>", { desc = "general save file" })
map("n", "<Esc>", "<CMD>noh<CR>", { desc = "general clear highlights" })

-- toggles
map("n", "<leader>tgn", "<CMD>set nu!<CR>", { desc = "toggle line number" })
map("n", "<leader>tgr", "<CMD>set rnu!<CR>", { desc = "toggle relative number" })

----------------------------------------------------------------------------------
---*[ INSERT MODE ]*--------------------------------------------------------------
----------------------------------------------------------------------------------

-- move cursor to beginning/end of line
map("i", "<C-b>", "<ESC>^i", { desc = "move beginning of line" })
map("i", "<C-e>", "<End>", { desc = "move end of line" })
map("i", "<C-h>", "<ESC>^i", { desc = "move beginning of line" })
map("i", "<C-l>", "<End>", { desc = "move end of line" })

-- enter to next/previous line
map("i", "<C-CR>", "<End><CR>")
map("i", "<S-CR>", "<ESC>O")

-- generalization | quality of life improvements
map("i", "<C-BS>", "<C-w>")
map("i", "<C-v>", "<C-r>+")
map("i", "<C-a>", "<ESC>GVgg")
map("i", "<C-s>", "<CMD>w<CR>")

----------------------------------------------------------------------------------
---*[ VISUAL MODE ]*--------------------------------------------------------------
----------------------------------------------------------------------------------

-- script: move line down/up
map("v", "<A-j>", ":m '>+1<CR>gv=gv")
map("v", "<A-k>", ":m '<-2<CR>gv=gv")
map("v", "J", "mzJ`z") -- save cursor position after joining lines

-- script: search selected selection
map("v", "/", '"vy /<C-r>v<CR>zz')
map("v", "?", '"vy ?<C-r>v<CR>zz')

-- QoL: reselect selection
map("v", "<", "<gv")
map("v", ">", ">gv")
map("v", "p", "pgvy") -- re-copy the pasted text

-- generalization
map("v", "<C-a>", "<ESC>GVgg")
map("v", "<C-s>", "<CMD>w<CR>")

-- auto recenter after scroll
map("v", "<C-d>", "<C-d>zz")
map("v", "<C-u>", "<C-u>zz")

-- go to beginning/end of line
map("v", "<C-h>", "<Home>")
map("v", "<C-l>", "<End>")
map("v", "H", "^")
map("v", "L", "$h")

-- Other Modes
map("c", "<C-v>", "<C-r>+")

----------------------------------------------------------------------------------
-----*[ PLUGINS ]*---------------------------------------------------------------
----------------------------------------------------------------------------------

--- [ Natives ] ---
map("n", "<leader>h", "<CMD>lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({0}),{0})<CR>")
map("n", "<leader>ds", vim.diagnostic.setloclist, { desc = "LSP diagnostic loclist" }) -- global lsp mappings

--- [ NvChad ] ---
map("n", "gh", "<leader>sh", { remap = true }) -- NvChad lspconfig | vim.lsp.buf.signature_help
map("n", "<leader>tgt", "<CMD>lua require('base46').toggle_transparency()<CR>")
map("n", "<leader>th", "<cmd>lua require('nvchad.themes').open()<CR>", { desc = "telescope nvchad themes" })

--- [ NvChad Terminals ] ---
map("t", "<C-x>", "<C-\\><C-N>", { desc = "terminal escape terminal mode" })
map("n", "<leader>teh", function()
  require("nvchad.term").new { pos = "sp" }
end, { desc = "terminal new horizontal term" })
map("n", "<leader>tev", function()
  require("nvchad.term").new { pos = "vsp" }
end, { desc = "terminal new vertical term" })
map({ "n", "t" }, "<A-v>", function()
  require("nvchad.term").toggle { pos = "vsp", id = "vtoggleTerm" }
end, { desc = "terminal toggleable vertical term" })
map({ "n", "t" }, "<A-h>", function()
  require("nvchad.term").toggle { pos = "sp", id = "htoggleTerm" }
end, { desc = "terminal toggleable horizontal term" })
map({ "n", "t" }, "<C-`>", function()
  require("nvchad.term").toggle {
    pos = "float",
    id = "floatTerm",
    float_opts = {
      row = 0.1,
      col = 0.1,
      width = 0.8,
      height = 0.8,
    },
  }
end, { desc = "terminal toggle floating term" })

--- [ Tabufline + buffers ] ---
map("n", "<C-j>", "<CMD>lua require('nvchad.tabufline').prev()<CR>", { desc = "change tab left" })
map("n", "<S-tab>", "<CMD>lua require('nvchad.tabufline').prev()<CR>", { desc = "change tab left" })
map("n", "<C-k>", "<CMD>lua require('nvchad.tabufline').next()<CR>", { desc = "change tab right" })
map("n", "<tab>", "<CMD>lua require('nvchad.tabufline').next()<CR>", { desc = "change tab right" })
map("n", "<C-q>", "<CMD>lua require('nvchad.tabufline').close_buffer() <CR>", { desc = "buffer close" })
map("n", "<leader>x", "<CMD>lua require('nvchad.tabufline').close_buffer() <CR>", { desc = "buffer close" })

map("n", "Q", "<CMD> Bdelete other <CR>", { desc = "close all other tab" })
map("n", "<leader>bn", "<cmd>enew<CR>", { desc = "buffer new" })

--- [ Comment ] ---
map({ "n", "i" }, "<C-/>", "<esc>gcc", { desc = "toggle comment", remap = true })
map("v", "<C-/>", "gcgv", { desc = "toggle comment", remap = true }) -- reselect comment

--- [ Misc. ] ---
map("n", "<leader>tgc", "<CMD>NvCheatsheet<CR>", { desc = "toggle nvcheatsheet" })
map("n", "<leader>oc", "<CMD>lua require('obsidian').util.toggle_checkbox() <CR>")
map("n", "<leader>fm", "<CMD>lua require('conform').format { lsp_fallback = true }<CR>", { desc = "format file" })
map("n", "<leader>gc", "<cmd>Telescope git_commits<CR>", { desc = "telescope git commits" })
map("n", "<leader>gst", "<cmd>Telescope git_status<CR>", { desc = "telescope git status" })
map("n", "<leader>pt", "<cmd>Telescope terms<CR>", { desc = "telescope pick hidden term" })
map("n", "<leader>wK", "<cmd>WhichKey <CR>", { desc = "whichkey all keymaps" })
map("n", "<leader>wk", function()
  vim.cmd("WhichKey " .. vim.fn.input "WhichKey: ")
end, { desc = "whichkey query lookup" })

--- [ Telescope Find ] ---
map("n", "<C-f>", "<CMD>Telescope live_grep<CR>", { desc = "telescope live grep" })
map("v", "<C-f>", '"zy <CMD>Telescope live_grep <CR><C-r>z', { desc = "search selection in all files" })
map("n", "<leader>fw", "<cmd>Telescope live_grep<CR>", { desc = "telescope live grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "telescope find buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "telescope help page" })
map("n", "<leader>fm", "<cmd>Telescope marks<CR>", { desc = "telescope find marks" })
map("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", { desc = "telescope find oldfiles" })
map("n", "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "telescope find in current buffer" })
map("n", "<leader>ft", "<CMD>Telescope tagstack<CR>")
map(
  "n",
  "<leader>fa",
  "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>",
  { desc = "🔭 find all files" }
)
map("n", "<C-p>", "<leader>ff", { remap = true }) -- search file

--- [ NvimTree ] ---
map("n", "<C-b>", "<cmd>NvimTreeToggle<CR>", { desc = "nvimtree toggle window" })
-- map("n", "<C-h>", "<leader>e", { remap = true }) -- focus file explorer if at the leftmost window and explorer is closed TODO: if condition check?
