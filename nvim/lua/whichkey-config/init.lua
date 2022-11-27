local wk = require("which-key")
local mappings = {
    q = {":q<CR>", "Quit"},
    Q = {":wq<CR>", "Save & Quit"},
    s = {":w<CR>", "Save"},
    O = {":so %<CR>", "Source"},
    x = {":bdelete<CR>", "Close"},
    E = {":e ~/.config/nvim/init.lua<CR>", "Edit config"},
    g = {":Goyo<CR>", "Toggle Goyo"},
    t = {":LLPStartPreview<CR>", "Preview Latex"},
    p = {":up | !xdg-open %<CR>", "Open program"},
    f = {":Telescope find_files<CR>", "Telescope Find Files"},
    r = {":Telescope live_grep<CR>", "Telescope Live Grep"},
    l = {
      name = "LSP",
      i = {":LspInfo<cr>", "Connected Language Servers"},
      A = {'<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', "Add workspace folder"},
      R = {'<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', "Remove workspace folder"},
      l = {'<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', "List workspace folder"},
      D = {'<cmd>lua vim.lsp.buf.type_definition()<CR>', "Type definition"},
      r = {'<cmd>lua vim.lsp.buf.rename()<CR>', "Rename"},
      a = {'<cmd>lua vim.lsp.buf.code_action()<CR>', "Code actions"},
      e = {'<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', "Show line diagnostics"},
      q = {'<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', "Show loclist"}
    },
    p = {
      name = "Packer",
      r = { ":PackerClean<cr>", "Remove Unused Plugins" },
      c = { ":PackerCompile profile=true<cr>", "Recompile Plugins" },
      i = { ":PackerInstall<cr>", "Install Plugins" },
      p = { ":PackerProfile<cr>", "Packer Profile" },
      s = { ":PackerSync<cr>", "Sync Plugins" },
      S = { ":PackerStatus<cr>", "Packer Status" },
      u = { ":PackerUpdate<cr>", "Update Plugins" }
    },
}
local opts = {prefix = '<leader>'}
wk.register(mappings, opts)


