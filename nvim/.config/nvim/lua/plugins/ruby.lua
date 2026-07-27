return {
  -- LSP pour Ruby (Solargraph ou Ruby LSP)
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Option 1 : ruby_lsp (recommandé, plus moderne)
        ruby_lsp = {
          mason = true,
          settings = {},
        },
        -- Option 2 : solargraph (alternative)
        -- solargraph = {
        --   mason = true,
        -- },
      },
    },
  },

  -- Mason pour installer les outils Ruby
  {
    "mason-org/mason.nvim",
    opts = { ensure_installed = { "rubocop" } },
  },

  -- Formatter/Linter Ruby avec conform.nvim et nvim-lint
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        ruby = { "rubocop" },
        eruby = { "erb_format" },
        haml = { "haml_lint" },
      },
      formatters = {
        haml_lint = {
          command = "haml-lint",
          args = { "--auto-correct", "$FILENAME" },
          stdin = false,
        },
      },
    },
  },

  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        ruby = { "rubocop" },
      },
    },
  },

  -- Support Rails (navigation entre model/controller/view)
  {
    "tpope/vim-rails",
    ft = { "ruby", "eruby" },
  },

  -- Bundle.vim (utile pour Gemfile)
  {
    "tpope/vim-bundler",
    ft = { "ruby" },
  },

  -- vim-rake pour Rakefile
  {
    "tpope/vim-rake",
    ft = { "ruby" },
  },

  -- Endwise : ajoute automatiquement "end" en Ruby
  {
    "RRethy/nvim-treesitter-endwise",
    event = "InsertEnter",
    ft = { "ruby" },
  },
}
