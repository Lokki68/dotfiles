return {
  "christoomey/vim-tmux-navigator",
  lazy = false,
  cmd = {
    "TmuxNavigateLeft",
    "TmuxNavigateRight",
    "TmuxNavigateTop",
    "TmuxNavigateBottom",
    "TmuxNavigatePrevious",
  },
  keys = {
    { "<c-h>", "<cmd>TmuxNavigateLeft<cr>", desc = "Go to left window" },
    { "<c-j>", "<cmd>TmuxNavigateBottom<cr>", desc = "Go to lower window" },
    { "<c-k>", "<cmd>TmuxNavigateTop<cr>", desc = "Go to upper window" },
    { "<c-l>", "<cmd>TmuxNavigateRight<cr>", desc = "Go to right window" },
    { "<c-//>", "<cmd>TmuxNavigatePrevious<cr>", desc = "Go to previous window" },
  },
}
