require("bufferline").setup{
    options = {
        offsets = {{filetype = "NvimTree", text = "File Explorer", highlight = "Directory", text_align = "left"}}
    }
}
vim.cmd[[
    nnoremap <silent><S-TAB> :BufferLineCycleNext<CR>
    nnoremap <silent><TAB> :BufferLineCycleNext<CR>
]]
