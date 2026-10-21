-- lua/plugins/vscode.lua
if not vim.g.vscode then
  return {}
end

local enabled = {
  "flash.nvim",
  "mini.ai",
  "mini.pairs",
  "mini.surround",
  "nvim-treesitter",
  "nvim-treesitter-textobjects",
  "nvim-ts-autotag",
  "ts-comments.nvim",
  "vim-repeat",
  "lazy.nvim",
  "LazyVim",
}

local Config = require("lazy.core.config")
Config.options.checker.enabled = false
Config.options.change_detection.enabled = false
Config.options.defaults.cond = function(plugin)
  return vim.tbl_contains(enabled, plugin.name) or plugin.vscode
end

vim.g.snacks_animate = false

return {
  {
    "LazyVim/LazyVim",
    config = function(_, opts)
      opts = vim.tbl_deep_extend("force", opts or {}, {
        defaults = { autocmds = false, keymaps = false },
      })
      require("lazyvim").setup(opts)
    end,
  },
}
