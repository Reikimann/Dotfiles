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
    r = {":Telescope live_grep<CR>", "Telescope Live Grep"}
}
local opts = {prefix = '<leader>'}
wk.register(mappings, opts)


