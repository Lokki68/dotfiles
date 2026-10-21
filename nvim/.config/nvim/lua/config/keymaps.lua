if not vim.g.vscode then
  --- Toggle thème clair/sombre
  local function toggle_theme()
    if vim.o.background == "dark" then
      vim.o.background = "light"
      vim.cmd.colorscheme("catppuccin-latte")
    else
      vim.o.background = "dark"
      vim.cmd.colorscheme("kanagawa")
    end
  end

  vim.keymap.set("n", "<leader>ut", toggle_theme, { desc = "Toggle light/dark theme" })
end
