return {
  -- Vue Language Server (Volar) intégré avec vtsls
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      local vue_language_server_path = vim.fn.stdpath("data")
        .. "/mason/packages/vue-language-server/node_modules/@vue/language-server"

      local vue_plugin = {
        name = "@vue/typescript-plugin",
        location = vue_language_server_path,
        languages = { "vue" },
        configNamespace = "typescript",
      }

      opts.servers.vtsls.settings.vtsls.tsserver.globalPlugins = {
        vue_plugin,
      }

      opts.servers.volar = {
        enabled = false, -- On utilise le mode hybride avec vtsls
      }
    end,
  },

  -- Mason : installer vue-language-server
  {
    "mason-org/mason.nvim",
    opts = { ensure_installed = { "vue-language-server" } },
  },
}
