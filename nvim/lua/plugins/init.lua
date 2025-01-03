return {
  --------------------------------------------------------------------------------
  --- NvChad stuffs ---
  --------------------------------------------------------------------------------
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    config = function()
      require "options"
    end,
  },

  "nvim-lua/plenary.nvim",

  {
    "nvchad/base46",
    build = function()
      require("base46").load_all_highlights()
    end,
  },

  {
    "nvchad/ui",
    lazy = false,
    config = function()
      require "nvchad"
    end,
  },

  "nvzone/volt",

  "nvzone/menu",

  { "nvzone/minty", cmd = { "Huefy", "Shades" } },

  {
    "nvim-tree/nvim-web-devicons",
    opts = function()
      dofile(vim.g.base46_cache .. "devicons")
      return { override = require "nvchad.icons.devicons" }
    end,
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    event = "User FilePost",
    opts = {
      indent = { char = "│", highlight = "IblChar" },
      scope = { char = "│", highlight = "IblScopeChar" },
    },
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "blankline")

      local hooks = require "ibl.hooks"
      hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
      require("ibl").setup(opts)

      dofile(vim.g.base46_cache .. "blankline")
    end,
  },

  -- file managing , picker etc
  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    opts = function()
      return require "configs.nvimtree"
    end,
  },

  {
    "folke/which-key.nvim",
    keys = { "<leader>", "<c-w>", '"', "'", "`", "c", "v", "g" },
    cmd = "WhichKey",
    opts = function()
      dofile(vim.g.base46_cache .. "whichkey")
      return {}
    end,
  },

  {
    -- git stuff
    "lewis6991/gitsigns.nvim",
    event = "User FilePost",
    opts = function()
      return require "configs.gitsigns"
    end,
  },

  {
    -- formatting!
    "stevearc/conform.nvim",
    event = "BufWritePre", -- for format on save
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "ruff-lsp" },
      },
    },
    config = function()
      require "configs.conform"
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      {
        "nvim-telescope/telescope-live-grep-args.nvim",
        -- This will not install any breaking changes.
        -- For major updates, this must be adjusted manually.
        version = "^1.0.0",
      },
    },
    opts = function()
      return require "configs.telescope"
    end,
  },
  {
    "nvim-telescope/telescope-project.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
  },

  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter", -- load luasnips + cmp related in insert mode only
    dependencies = {
      {
        -- snippet plugin
        "L3MON4D3/LuaSnip",
        dependencies = {
          "rafamadriz/friendly-snippets",
          "mstuttgart/vscode-odoo-snippets",
        },
        opts = { history = true, updateevents = "TextChanged,TextChangedI" },
        config = function(_, opts)
          require("luasnip").config.set_config(opts)
          require("luasnip.loaders.from_vscode").lazy_load()
          require "configs.luasnip"
        end,
      },

      {
        -- autopairing of (){}[] etc
        "windwp/nvim-autopairs",
        opts = {
          fast_wrap = {},
          disable_filetype = { "TelescopePrompt", "vim" },
        },
        config = function(_, opts)
          require("nvim-autopairs").setup(opts)

          -- setup cmp for autopairs
          local cmp_autopairs = require "nvim-autopairs.completion.cmp"
          require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end,
      },

      -- cmp sources plugins
      {
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
      },
    },
    opts = function()
      return require "configs.cmp"
    end,
  },

  {
    -- lsp stuff
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUpdate" },
    opts = function()
      return require "configs.mason"
    end,
  },

  {
    "neovim/nvim-lspconfig",
    event = "User FilePost",
    config = function()
      require("configs.lspconfig").defaults()
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    build = ":TSUpdate",
    lazy = false,
    opts = function()
      return require "configs.treesitter"
    end,
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
      require("nvim-treesitter.configs").setup {
        ensure_installed = { "markdown" },
        highlight = {
          enable = true,
          disable = { "latex" },
          additional_vim_regex_highlighting = { "latex", "markdown" },
        },
      }
    end,
  },

  --------------------------------------------------------------------------------
  --------------------------------------------------------------------------------

  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup {}
    end,
  },

  {
    -- multiple cursor
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

  {
    -- competitive programming test runner
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
    "nvchad/base46",
    lazy = true,
    build = function()
      require("base46").load_all_highlights()
    end,
  },

  {
    -- fast vim navigation (like vimium)
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

  {
    -- odoo stuffs
    "mstuttgart/vscode-odoo-snippets",
    event = "InsertEnter",
  },
  {
    "Desdaemon/odoo-lsp",
    cond = vim.fn.getcwd() == vim.fn.expand "~/work/odoo" or vim.fn.getcwd() == vim.fn.expand "~/work/enterprise",
  },

  {
    -- LaTeX !
    "lervag/vimtex",
    lazy = false, -- we don't want to lazy load VimTeX
    -- tag = "v2.15", -- uncomment to pin to a specific release
    init = function()
      -- VimTeX configuration goes here, e.g.
      local o = vim.o
      local g = vim.g

      g.tex_flavor = "latex"
      g.vimtex_view_method = "zathura"
      g.vimtex_quickfix_mode = 0
      o.conceallevel = 1
      g.tex_conceal = "abdmg"
      g.vimtex_compiler_latexmk = {
        out_dir = vim.fn.getcwd() .. "/build",
      }
    end,
  },

  {
    --LaTeX snippets from Gilles Castel
    "iurimateus/luasnip-latex-snippets.nvim",
    -- vimtex isn't required if using treesitter
    ft = { "tex" },
    requires = { "L3MON4D3/LuaSnip", "lervag/vimtex" },
    config = function()
      require("luasnip-latex-snippets").setup()
      -- or setup({ use_treesitter = true })
      require("luasnip").config.setup { enable_autosnippets = true }
      require "configs.luasnip-latex-snippets"
    end,
  },

  {
    "jbyuki/nabla.nvim",
  },
}
