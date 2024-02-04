local M = {}

function M.nvimTreeToggle()
  local api = require("nvim-tree.api")
  local currentBuf = api.tree.is_tree_buf(nil)

  if currentBuf then
    api.tree.close()
  else
    api.tree.focus()
  end
end

function M.nvimTreeAttach(bufnr)
  local api = require("nvim-tree.api")

  local function opts(desc)
    return { desc = 'nvim-tree: ' .. desc, noremap = true, silent = true, nowait = true }
  end

  api.config.mappings.default_on_attach(bufnr)

  vim.api.nvim_set_keymap('n', '<C-P>', "<cmd>lua require('nvim-tree.api').tree.change_root_to_node()<CR>", opts('CD'))
end

return M
