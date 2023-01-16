require'nvim-treesitter.configs'.setup {
    ensure_installed = {"help", "html", "python", "javascript", "lua", "latex", "rust"},
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    rainbow = {
        enable = true,
        extended_mode = false, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
        max_file_lines = nil, -- Do not enable for files with more than n lines, int
    },
    autotag = {
        enable = true,
        --filetypes = { "html" , "xml" },
    }
}
