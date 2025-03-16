return {
  "EdenEast/nightfox.nvim",
  version = false,
  lazy = false,
  priority = 1000, -- make sure to load this before all the other start plugins
  -- Optional; default configuration will be used if setup isn't called.
  config = function()
    require("nightfox").setup({
      -- Your config here
      options = {
        transparent = true,
        palettes = { "nordfox" },
      },
    })
  end,
}
