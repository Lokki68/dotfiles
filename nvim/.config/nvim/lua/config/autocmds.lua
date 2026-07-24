vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    if vim.o.background == "light" then
      -- Curseur plus contrasté sur fond clair
      vim.api.nvim_set_hl(0, "Cursor", { bg = "#1E66F5", fg = "#EFF1F5" })
      vim.api.nvim_set_hl(0, "iCursor", { bg = "#D20F39", fg = "#EFF1F5" })
    else
      -- Comportement par défaut sur Kanagawa
      vim.api.nvim_set_hl(0, "Cursor", { bg = "#E6C384", fg = "#1F1F28" })
      vim.api.nvim_set_hl(0, "iCursor", { bg = "#E46876", fg = "#1F1F28" })
    end
  end,
})
