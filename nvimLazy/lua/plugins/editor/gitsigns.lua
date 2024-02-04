return {
  "lewis6991/gitsigns.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  event = "BufRead",
  opts = {
    current_line_blame = true,
  },
  config = function(_, opts)
    require('gitsigns').setup(opts)
  end,
}
