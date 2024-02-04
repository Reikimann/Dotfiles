return {
  'akinsho/bufferline.nvim',
  dependencies = 'nvim-tree/nvim-web-devicons',
  event = "VeryLazy",
  keys = {
    { "<TAB>", "<cmd>BufferLineCycleNext<cr>", desc = "Bufferline Next" },
    { "<S-TAB>", "<cmd>BufferLineCyclePrev<cr>", desc = "Bufferline Previous" },
  },
  opts = { 
    options = {
      always_show_bufferline = false,
      offsets = {
        { 
          filetype = "NvimTree",
          text = "File Explorer",
          highlight = "Directory",
          text_align = "left",
        },
      },
    },
  },
  config = function(_, opts)
    require("bufferline").setup(opts)
  end,
}
