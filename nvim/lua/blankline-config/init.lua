require("indent_blankline").setup {
  -- for example, context is off by default, use this to turn it on
  show_current_context = true,
  show_current_context_start = false,
  space_char_blankline = " ",

  filetype_exclude = {"dashboard", "NvimTree", "Mason", "packer", "lsp-installer"},
  buftype_exclude = {"terminal", "help"},
}

vim.opt.list = true
-- vim.opt.listchars:append("leadmultispace:⋅")
