vim.cmd('filetype plugin indent on')

local opt = vim.opt

opt.shortmess = vim.o.shortmess .. 'c'
opt.hidden = true
opt.whichwrap = 'b,s,<,>,[,],h,l'
opt.pumheight = 10
opt.fileencoding = 'utf-8'
opt.list = true
-- https://neovim.io/doc/user/options.html#lcs-leadmultispace
-- opt.listchars = "trail:-"
-- opt.listchars:append("leadmultispace:⋅")
-- opt.listchars = "trail:⋅,leadmultispace:⋅"
opt.splitbelow = true
opt.splitright = true
opt.termguicolors = true
opt.cmdheight = 1
-- opt.conceallevel = 0 -- set in vimtex
opt.showtabline = 1
opt.laststatus = 3 -- Always display the status line
opt.showmode = false
opt.backup = false
opt.writebackup = false
opt.swapfile = false
opt.updatetime = 500
opt.timeoutlen = 100
opt.hlsearch = false
opt.incsearch = true
opt.ignorecase = true
opt.scrolloff = 15
-- opt.sidescrolloff = 5
opt.mouse = ""
opt.wrap = true
opt.linebreak = true
opt.number = true
opt.relativenumber = true
opt.signcolumn = 'yes'
opt.tabstop = 2
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.shiftwidth = 2
opt.autoindent = true
opt.autoindent = true
opt.expandtab = true
opt.expandtab = true

vim.g.vsnip_snippet_dir = vim.fn.expand('~/.config/nvim/lua/vsnippets/')



