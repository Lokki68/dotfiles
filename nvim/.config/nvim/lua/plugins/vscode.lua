-- Mode VSCode : on garde tout LazyVim (dépendances internes comme Snacks incluses)
-- et on désactive uniquement les plugins purement UI / IDE.
if not vim.g.vscode then
  return {}
end

-- Plugins inutiles dans VSCode (UI, LSP, completion, debug...)
local disabled = {
  "akinsho/bufferline.nvim",
  "nvim-lualine/lualine.nvim",
  "folke/noice.nvim",
  "rcarriga/nvim-notify",
  "nvimdev/dashboard-nvim",
  "folke/which-key.nvim",
  "lukas-reineke/indent-blankline.nvim",
  "nvim-mini/mini.indentscope",
  "nvim-neo-tree/neo-tree.nvim",
  "folke/trouble.nvim",
  "folke/todo-comments.nvim",
  "lewis6991/gitsigns.nvim",
  "stevearc/conform.nvim",
  "mfussenegger/nvim-lint",
  "neovim/nvim-lspconfig",
  "mason-org/mason.nvim",
  "mason-org/mason-lspconfig.nvim",
  "hrsh7th/nvim-cmp",
  "saghen/blink.cmp",
  "mfussenegger/nvim-dap",
  "rcarriga/nvim-dap-ui",
  "christoomey/vim-tmux-navigator",
  "folke/persistence.nvim",
  "folke/flash.nvim", -- retiré de cette liste si tu veux le garder (voir plus bas)
}

local specs = {}
for _, name in ipairs(disabled) do
  table.insert(specs, { name, enabled = false })
end

-- On garde flash.nvim : on le réactive explicitement
specs[#specs] = { "folke/flash.nvim", enabled = true, vscode = true }

-- Les plugins d'édition fonctionnent dans VSCode grâce à `vscode = true`
vim.list_extend(specs, {
  { "kylechui/nvim-surround", vscode = true },
  { "nvim-treesitter/nvim-treesitter", vscode = true },
  { "nvim-treesitter/nvim-treesitter-textobjects", vscode = true },
})

return specs
