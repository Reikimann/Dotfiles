vim.g.mapleader = ' '
local map = vim.api.nvim_set_keymap
map('n', '<C-h>', '<C-w>h', {noremap = true, silent = false})
map('n', '<C-l>', '<C-w>l', {noremap = true, silent = false})
map('n', '<C-j>', '<C-w>j', {noremap = true, silent = false})
map('n', '<C-k>', '<C-w>k', {noremap = true, silent = false})

map('i', 'jk', '<ESC>', {noremap = true, silent = false})
map('i', 'kj', '<ESC>', {noremap = true, silent = false})

map('n', '<leader>e', ':NvimTreeToggle<CR>', {noremap = true, silent = true})

map('v', '<', '<gv', {noremap = true, silent = false})
map('v', '>', '>gv', {noremap = true, silent = false})

map('v', 'J', ":m '>+1<CR>gv=gv", {noremap = true, silent = false})
map('v', 'K', ":m '<-2<CR>gv=gv", {noremap = true, silent = false})

map('v', 'u', "t_", {noremap = true, silent = false})

map('n', 'cu', "ct_", {noremap = true, silent = false})

map("n", "J", "mzJ`z", {noremap = true, silent = false})

map("n", "<C-d>", "<C-d>zz", {noremap = true, silent = false})
map("n", "<C-u>", "<C-u>zz", {noremap = true, silent = false})
map("n", "n", "nzzzv", {noremap = true, silent = false})
map("n", "N", "Nzzzv", {noremap = true, silent = false})

map("x", "<leader>P", [["_dP]], {noremap = true, silent = false })

map("n", "<leader>y", [["+y]], {noremap = true, silent = false })
map("v", "<leader>y", [["+y]], {noremap = true, silent = false })

map("n", "<leader>d", [["_d]], {noremap = true, silent = false })
map("v", "<leader>d", [["_d]], {noremap = true, silent = false })

map("n", "<M-u>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1, '<c-u>')<cr>", {noremap = true, silent = true})
map("n", "<M-d>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1, '<c-d>')<cr>", {noremap = true, silent = true})
