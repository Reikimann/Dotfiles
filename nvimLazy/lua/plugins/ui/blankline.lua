local exclude_ft = {
  "help", "git",
  "markdown", "snippets",
  "text", "gitconfig",
  "alpha", "dashboard",
  "Trouble", "trouble",
  "lazy", "mason",
  "notify", "toggleterm",
}

return {
  "lukas-reineke/indent-blankline.nvim",
  event = "BufRead",
  main = "ibl",
  opts = {
    whitespace = {
      remove_blankline_trail = false,
    },
    scope = {
      show_start = false,
      show_end = false,
    },
    exclude = {
      filetypes = exclude_ft,
      buftypes = { "terminal" },
    },
  },
}
