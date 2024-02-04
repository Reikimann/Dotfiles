return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  opts = {
    prefix = '<leader>'
  },
  config = function(_, opts)
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
      b = {
        name = "Buffers",
        d = {":bdelete<CR>", "Delete"},
      },
      f = {
        name = "File",
        s = {":w<CR>", "Save"},
        S = {":so %<CR>", "Source"},
      },
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
        m = {":Telescope noice<CR>", "Telescope Messages"},
        r = {":Telescope live_grep<CR>", "Telescope Live Grep"},
        c = {":Telescope colorscheme<CR>", "Telescope Colorscheme"},
        b = {":ToggleTerm<cr>", "Split Below"},
        f = {toggle_float, "Floating Terminal"},
        g = {toggle_lazygit, "LazyGit"},
      },
      o = {
        name = "Operations",
        x = {"<cmd>silent !chmod +x %<CR>", "Make executable"},
      -- o = {":up | !xdg-open %<CR>", "Open program"},
      },
      a = {
        name = "Other",
      },
      p = {":Lazy<cr>", "Plugins"}
    }
    wk.setup(opts)
    wk.register(mappings, opts)
  end,
}
