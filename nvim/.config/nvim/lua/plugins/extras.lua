return {
  -- Meilleure gestion des imports auto TS/JS
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {},
    enabled = false, -- activer si vous préférez ça à vtsls
  },

  -- Copilot (si vous l'utilisez)
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    opts = {},
  },

  -- Meilleure UI pour git (utile en équipe)
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
  },

  -- dbee ou vim-dadbod pour interagir avec la BDD Rails
  {
    "tpope/vim-dadbod",
    dependencies = {
      "kristijanhusak/vim-dadbod-ui",
      "kristijanhusak/vim-dadbod-completion",
    },
    cmd = { "DBUI", "DBUIToggle", "DBUIAddConnection" },
  },
}
