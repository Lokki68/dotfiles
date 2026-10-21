-- Raccourcis et options spécifiques à VSCode (extension vscode-neovim)
if vim.g.vscode then
  require("config.vscode")
end

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
