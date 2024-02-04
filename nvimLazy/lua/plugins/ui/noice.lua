return {
  "folke/noice.nvim",
  event = "VeryLazy",
  opts = {};
  dependencies = {
    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  },
  presets = {
    lsp_doc_border = true,
  },
}
