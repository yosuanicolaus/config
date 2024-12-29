local nvchad_plugins = require "nvchad.plugins"

local custom_plugins = {
  --------------------------------------------------------------------------------
  ----- Overrides NvChad's plugins -----
  --------------------------------------------------------------------------------
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      -- {
      --   "nvim-telescope/telescope-live-grep-args.nvim",
      --   -- This will not install any breaking changes.
      --   -- For major updates, this must be adjusted manually.
      --   version = "^1.0.0",
      -- },
    },
    opts = function()
      return require "configs.telescope"
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    opts = function()
      return require "configs.cmp"
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "lua-language-server",
        "bash-language-server",
        "markdown-oxide",
        "rust-analyzer",
        "basedpyright",
        "html-lsp",
        "css-lsp",
        "harper-ls",
        "stylua",
        "prettier",
        "ast-grep",
        "gdtoolkit",
        "ruff",
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
        "rust",
        "python",
        "bash",
        "gdscript",
        "gdshader",
        "godot_resource",
      },
    },
  },
  --------------------------------------------------------------------------------
  ------ Overrides end -----
  --------------------------------------------------------------------------------

  --------------------------------------------------------------------------------
  --------------------------------------------------------------------------------

  {
    -- 2023-08-04
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup {}
    end,
  },

  {
    "mg979/vim-visual-multi",
    lazy = false,
  },

  {
    -- 2023-11-13 markdown preview in browser
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },

  -- 2024-01-31 competitive programming problem parser
  {
    "xeluxee/competitest.nvim",
    dependencies = "MunifTanjim/nui.nvim",
    cmd = { "CompetiTest" },
    config = function()
      local base_dir = "/home/yosuanicolaus/codes/competitive-rust"
      require("competitest").setup {
        editor_ui = {
          show_rnu = true,
          normal_mode_mappings = {
            switch_window = { "<C-i>", "<CR>", "<S-CR>" },
          },
          insert_mode_mappings = {
            switch_window = { "<C-i>" },
            save_and_close = "<C-s>",
            cancel = "<C-q>",
          },
        },
        popup_ui = {
          layout = {
            { 2, { { 1, "si" }, { 1, "tc" } } },
            { 4, { { 1, { { 1, "so" }, { 1, "eo" } } }, { 1, "se" } } },
          },
        },
        compile_command = {
          rust = {
            exec = "rustc",
            args = {
              "--edition=2021",
              "-o",
              base_dir .. "/target/debug/competitest",
              base_dir .. "/main/src/main.rs",
            },
          },
        },
        run_command = {
          rust = { exec = base_dir .. "/target/debug/competitest" },
        },
        testcases_directory = "../tests/",
        testcases_input_file_format = "$(TCNUM).in",
        testcases_output_file_format = "$(TCNUM).out",
      }
    end,
  },

  {
    -- 2024-02-04 Obsidian
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    -- ft = "markdown",
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    event = {
      "BufReadPre /home/yosuanicolaus/codes/obsidian/**.md",
      "BufNewFile /home/yosuanicolaus/codes/obsidian/**.md",
    },
    dependencies = {
      -- Required.
      "nvim-lua/plenary.nvim",
    },
    opts = {
      -- https://github.com/epwalsh/obsidian.nvim#configuration-options
      workspaces = {
        {
          name = "obsidian",
          path = "~/codes/obsidian/",

          overrides = {
            daily_notes = {
              folder = "diary",
              date_format = "%y%m%d",
            },
            -- completion = {
            --   new_notes_location = "notes_subdir",
            -- },
            note_id_func = function(title)
              -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
              -- In this case a note with the title 'My new note' will be given an ID that looks
              -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
              local suffix = ""
              if title ~= nil then
                -- If title is given, transform it into valid file name.
                suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
              else
                -- If title is nil, just add 4 random uppercase letters to the suffix.
                for _ = 1, 4 do
                  suffix = suffix .. string.char(math.random(65, 90))
                end
              end
              return suffix
            end,

            templates = {
              subdir = "template",
              date_format = "%y%m%d",
              time_format = "%H:%M",
            },
          },
        },
      },
    },
  },

  {
    -- Write in sudo mode
    "lambdalisue/vim-suda",
    cmd = { "SudaRead", "SudaWrite" },
  },

  {
    -- close all other buffers except current (:Bdelete other)
    "Asheq/close-buffers.vim",
    cmd = { "Bdelete" },
  },

  {
    "nvchad/ui",
    config = function()
      require "nvchad"
    end,
  },

  {
    "nvchad/base46",
    lazy = true,
    build = function()
      require("base46").load_all_highlights()
    end,
  },

  -- 241224 Post Doom Emacs & Spacemacs trial
  -- Let's make nvim great

  {
    -- motions: I am speed, baby
    -- <leader><leader>w
    -- <leader><leader>s (char)
    "easymotion/vim-easymotion",
    lazy = false,
  },

  {
    -- automatically adjusts 'shiftwidth' and 'expandtab' heuristically
    "tpope/vim-sleuth",
    lazy = false,
  },

  {
    -- automatically save project session
    "rmagatti/auto-session",
    lazy = false,
    opts = {
      suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
    },
  },

  {
    -- tab out in insert mode
    "kawre/neotab.nvim",
    event = "InsertEnter",
    opts = {
      -- configuration goes here
    },
  },

  {
    -- git blame line
    "f-person/git-blame.nvim",
    event = "VeryLazy",
    opts = {
      message_template = "<author> • <date> • <summary> • <<sha>>", -- template for the blame message, check the Message template section for more options
      date_format = "%d %B %Y", -- template for the date, check Date format section for more options
      virtual_text_column = 110, -- virtual text start column, check Start virtual text at column section for more options
      delay = 100,
      message_when_not_committed = "",
    },
  },
}

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

--- Merge table from custom_plugins to nvchad_plugins if the first key matches

local nvchad_clean = {}
for _, nvchad_setting in ipairs(nvchad_plugins) do
  if type(nvchad_setting) == "string" then
    nvchad_setting = { nvchad_setting }
  end
  nvchad_clean[nvchad_setting[1]] = nvchad_setting
end
local custom_clean = {}
for _, custom_setting in ipairs(custom_plugins) do
  custom_clean[custom_setting[1]] = custom_setting
end

local final_plugins = {}

for nvchad_key, nvchad_setting in pairs(nvchad_clean) do
  if custom_clean[nvchad_key] ~= nil then
    nvchad_setting = vim.tbl_deep_extend("force", nvchad_setting, custom_clean[nvchad_key])
  end
  table.insert(final_plugins, nvchad_setting)
end

for custom_key, custom_setting in pairs(custom_clean) do
  if nvchad_clean[custom_key] == nil then
    table.insert(final_plugins, custom_setting)
  end
end

return final_plugins
