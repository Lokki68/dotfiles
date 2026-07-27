return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        -- Web / JS-TS
        "javascript",
        "typescript",
        "tsx",
        "json",
        "jsonc",
        "html",
        "css",
        "vue",

        -- Ruby / Rails
        "ruby",
        "erb",
        "haml",

        -- Général
        "yaml",
        "sql",
        "dockerfile",
      },
    },
  },
}
