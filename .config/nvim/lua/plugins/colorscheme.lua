return {
  "EdenEast/nightfox.nvim",
  version = false,
  lazy = false,
  priority = 1000,

  config = function()
    require("nightfox").setup({
      options = {
        transparent = true,
        palettes = { "nordfox" },
      },
    })
  end,
}
