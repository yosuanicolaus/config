return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
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
        "html-lsp",
        "css-lsp",
        "harper-ls",
        "stylua",
        "prettier",
        "ast-grep",
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
        "bash",
      },
    },
  },

  -- 2023-08-04
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup {
        -- Configuration here, or leave empty to use defaults
      }
    end,
  },

  {
    "mg979/vim-visual-multi",
    lazy = false,
  },

  -- 2023-11-13 markdown preview in browser
  {
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
    keys = {
      { "<leader>cprp", "<cmd> CompetiTest receive problem <CR>" },
      { "<leader>cprt", "<cmd> CompetiTest receive testcases <CR>" },
    },
    config = function()
      require("competitest").setup {}
    end,
  },

  -- 2024-02-04 Obsidian
  {
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

  -- 240524 Write in sudo
  {
    "lambdalisue/vim-suda",
    cmd = { "SudaRead", "SudaWrite" },
  },
}
