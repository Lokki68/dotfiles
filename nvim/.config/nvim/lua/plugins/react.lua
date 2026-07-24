return {
  -- Auto-fermeture des tags HTML/JSX
  {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
    opts = {},
  },

  -- Emmet pour JSX/TSX
  {
    "mattn/emmet-vim",
    ft = {
      "html",
      "javascriptreact",
      "typescriptreact",
      "vue",
      "css",
    },
    init = function()
      vim.g.user_emmet_leader_key = "<C-e>"
    end,
  },

  -- Highlight des couleurs (utile pour Tailwind/CSS-in-JS)
  {
    "brenoprata10/nvim-highlight-colors",
    event = "BufReadPre",
    opts = {
      render = "background",
    },
  },
}
