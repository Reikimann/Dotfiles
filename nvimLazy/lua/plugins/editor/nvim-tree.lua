return {
  'kyazdani42/nvim-tree.lua',
  dependencies = { 'kyazdani42/nvim-web-devicons' },
  lazy = true,
  keys = {
    { "<leader>e", "<cmd>lua require('util.navigation').nvimTreeToggle()<cr>", desc = "Toggle NvimTree" },
  },
  opts = {
    disable_netrw = true,
    hijack_netrw = true,
    open_on_tab = false,
    hijack_cursor = false,
    update_cwd = false,
    sync_root_with_cwd = true,
    diagnostics = {
      enable = true,
      icons = {
        hint = "",
        info = "",
        warning = "",
        error = "",
      },
    },
    renderer = {
      indent_markers = {
        enable = true,
        icons = {
          corner = "╰",
          edge = "│ ",
          none = "  ",
        },
      },
    },
    update_focused_file = {
      enable = false,
      update_cwd = false,
      ignore_list = {}
    },
    system_open = {
      cmd  = nil,
      args = {}
    },
    filters = {
      custom = { "^.git$" },
    },
    git = {
      enable = true,
      ignore = true,
      timeout = 500,
    },
    view = {
      width = 30,
      side = 'left',
      signcolumn = "yes",
      number = false,
      relativenumber = false,
    },
    trash = {
      cmd = "trash",
      require_confirm = true,
    },
    on_attach = function(bufnr)
      require("util.navigation").nvimTreeAttach(bufnr)
    end,
  },
}
