local wk = require("which-key")
local Terminal = require("toggleterm.terminal").Terminal
local toggle_float = function ()
  local float = Terminal:new({direction = "float"})
  return float:toggle()
end
local toggle_lazygit = function ()
  local lazygit = Terminal:new({cmd = "lazygit", direction = "float"})
  return lazygit:toggle()
end

local mappings = {
    q = {":q<CR>", "Quit"},
    Q = {":wq<CR>", "Save & Quit"},
    s = {":w<CR>", "Save"},
    O = {":so %<CR>", "Source"},
    x = {":bdelete<CR>", "Close"},
    l = {
      name = "LSP",
      i = {":LspInfo<cr>", "Connected Language Servers" },
      k = {"<cmd>lua vim.lsp.buf.signature_help()<cr>", "Signature Help" },
      K = {"<cmd>Lspsaga hover_doc<cr>", "Hover Commands" },
      w = {'<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>', "Add Workspace Folder" },
      W = {'<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>', "Remove Workspace Folder" },
      l = {
        '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>',
        "List Workspace Folders"
      },
      r = {'<cmd>lua vim.lsp.buf.references()<cr>', "References" },
      t = {'<cmd>lua vim.lsp.buf.type_definition()<cr>', "Type Definition" },
      d = {'<cmd>lua vim.lsp.buf.definition()<cr>', "Go To Definition" },
      D = {'<cmd>lua vim.lsp.buf.declaration()<cr>', "Go To Declaration" },
      p = {'<cmd>Lspsaga peek_definition<cr>', "Preview Definition" },
      R = {'<cmd>Lspsaga rename<cr>', "Rename" },
      a = {'<cmd>Lspsaga code_action<cr>', "Code Action" },
      e = {'<cmd>Lspsaga show_line_diagnostics<cr>', "Show Line Diagnostics" },
      n = {'<cmd>Lspsaga diagnostic_jump_next<cr>', "Go To Next Diagnostic" },
      N = {'<cmd>Lspsaga diagnostic_jump_prev<cr>', "Go To Previous Diagnostic" }
    },
    t = {
      name = "Toggles",
      j = {":Telescope find_files<CR>", "Telescope Find Files"},
      o = {":Telescope oldfiles<CR>", "Telescope Recent Files"},
      r = {":Telescope live_grep<CR>", "Telescope Live Grep"},
      c = {":Telescope colorscheme<CR>", "Telescope Colorscheme"},
      t = {":ToggleTerm<cr>", "Split Below"},
      m = {toggle_float, "Floating Terminal"},
      l = {toggle_lazygit, "LazyGit"},
    },
    o = {
      name = "Operations",
      x = {"<cmd>silent !chmod +x %<CR>", "Make executable"},
    -- o = {":up | !xdg-open %<CR>", "Open program"},
    },
    a = {
      name = "Other",
      y = {":LLPStartPreview<CR>", "Preview Latex"},
    },
    p = {
      name = "Packer",
      r = {":PackerClean<cr>", "Remove Unused Plugins" },
      c = {":PackerCompile profile=true<cr>", "Recompile Plugins" },
      i = {":PackerInstall<cr>", "Install Plugins" },
      p = {":PackerProfile<cr>", "Packer Profile" },
      s = {":PackerSync<cr>", "Sync Plugins" },
      S = {":PackerStatus<cr>", "Packer Status" },
      u = {":PackerUpdate<cr>", "Update Plugins" }
    },
}
local opts = {prefix = '<leader>'}
wk.register(mappings, opts)


