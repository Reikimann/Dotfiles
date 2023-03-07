vim.cmd('filetype plugin indent on')
vim.o.shortmess = vim.o.shortmess .. 'c'
vim.o.hidden = true
vim.o.whichwrap = 'b,s,<,>,[,],h,l'
vim.o.pumheight = 10
vim.o.fileencoding = 'utf-8'
vim.o.splitbelow = true
vim.o.splitright = true
vim.opt.termguicolors = true
vim.o.cmdheight = 1
-- vim.o.conceallevel = 0 -- set in vimtex
vim.o.showtabline = 1
vim.o.laststatus = 3 -- Always display the status line
vim.o.showmode = false
vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false
vim.o.updatetime = 500
vim.o.timeoutlen = 100
vim.o.hlsearch = false
vim.o.incsearch = true

vim.o.ignorecase = true
vim.o.scrolloff = 15
-- vim.o.sidescrolloff = 5
vim.wo.wrap = true
vim.wo.linebreak = true
vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.signcolumn = 'yes'
vim.o.tabstop = 2
vim.bo.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.bo.shiftwidth = 2
vim.o.autoindent = true
vim.bo.autoindent = true
vim.o.expandtab = true
vim.bo.expandtab = true

vim.g.vsnip_snippet_dir = vim.fn.expand('~/.config/nvim/lua/vsnippets/')



