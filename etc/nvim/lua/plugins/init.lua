return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- test new blink
  -- { import = "nvchad.blink.lazyspec" },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      highlight = { enable = true },
      indent = { enable = true },
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "c",
        "dart",
        "fish",
        "glsl",
        "cpp",
        "bash",
        "cmake",
        "python",
        "cuda",
        "markdown",
        "markdown_inline",
        "json",
        "matlab",
        "nasm",
        "sql",
      },
    },
  },

  {
    "hedyhli/outline.nvim",
    cmd = { "Outline", "OutlineOpen" },
    keys = {
      { "<leader>o", "<cmd>Outline<CR>", desc = "toggle outline" },
    },
    opts = {
    },
  },

  {
    "folke/which-key.nvim",
    lazy = false,
  },

  {
    "declancm/cinnamon.nvim",
    version = "*", -- use latest release
    keys = function()
      local cinnamon = require("cinnamon")  -- Cache locally
      return {
        { "<C-U>", function() cinnamon.scroll("<C-U>zz") end, desc = "centered scrolling up", mode = { "n" } },
        { "<C-D>", function() cinnamon.scroll("<C-D>zz") end, desc = "centered scrolling down" , mode = { "n" } },
      }
    end,
    opts = {
      keymaps = {
          basic = false,
          extra = false,
      },
      options = {
        mode = "window",
        delay = 8,
      },
    },
  },

  {
    'MagicDuck/grug-far.nvim',
    keys = {
      { "<leader>fr", "<cmd>GrugFar<CR>", desc = "find and replace" },
    },
    config = function()
      require('grug-far').setup({
        normalModeSearch = true,
        startInInsertMode = false,
        wrap = false,
        resultsHighlight = false,
        inputsHighlight = false,
        resultLocation = {
          showNumberLabel = false,
        },
      });
    end
  },

  {
    "NeogitOrg/neogit",
    keys = {
      { "<leader>gg", "<cmd>Neogit<CR>", desc = "open neogit" },
    },
    config = function()
      require("neogit").setup({
        integrations = {
          diffview = false,
        },
        mappings = {
          popup = {
            ["d"] = false,
          }
        }
      })
      dofile(vim.g.base46_cache .. "git")
      dofile(vim.g.base46_cache .. "neogit")
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
  },

  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
      modes = {
        char = {
          enabled = false,
        },
      },
    },
    keys = {
      { "s", mode = { "n" }, function() require("flash").jump() end, desc = "flash" },
      { "S", mode = { "n" }, function() require("flash").treesitter() end, desc = "flash teesitter" },
    },
  },

}
