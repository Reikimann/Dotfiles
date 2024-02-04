return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ":TSUpdate",
    event = "VeryLazy",
    opts = {
      ensure_installed = {
        "bash",
        "diff",
        "html",
        "javascript",
        "jsdoc",
        "markdown",
        "markdown_inline",
        "regex",
        "python",
        "json",
        "jsonc",
        "lua",
        "tsx",
        "typescript",
        "latex",
        "rust",
        "yuck",
        "yaml",
        "css",
      },
      highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
      },
      rainbow = {
          enable = true,
          extended_mode = false, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
          max_file_lines = nil, -- Do not enable for files with more than n lines, int
      },
      indent = { enable = true },
      autotag = {
          enable = true,
          --filetypes = { "html" , "xml" },
      },
    },
    config = function(_, opts)
      if type(opts.ensure_installed) == "table" then
          ---@type table<string, boolean>
          local added = {}
          opts.ensure_installed = vim.tbl_filter(function(lang)
            if added[lang] then
              return false
            end
            added[lang] = true
            return true
          end, opts.ensure_installed)
        end
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
  {
    "p00f/nvim-ts-rainbow",
    event = "VeryLazy",
    dependencies = "nvim-treesitter/nvim-treesitter",
  },
  {
    "windwp/nvim-ts-autotag",
    event = "VeryLazy",
    dependencies = "nvim-treesitter/nvim-treesitter",
  }
}
