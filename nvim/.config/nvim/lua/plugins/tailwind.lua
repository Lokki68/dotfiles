return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        tailwindcss = {
          filetypes = {
            "html",
            "javascript",
            "javascriptreact",
            "typescript",
            "typescriptreact",
            "vue",
            "erb", -- utile si tailwind dans les vues Rails
            "haml",
          },
        },
      },
    },
  },
}
