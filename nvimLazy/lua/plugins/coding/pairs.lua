-- TODO: Maybe use nvim-autopairs instead.
return {
  "echasnovski/mini.pairs",
  event = "VeryLazy",
  opts = {},
  config = function()
    require('mini.pairs').setup()
  end,
}
