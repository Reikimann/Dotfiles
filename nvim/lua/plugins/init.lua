return require('packer').startup({
  function(use)
    -- Packer can manage itself
    use {'wbthomason/packer.nvim'}
    -------------COLORSCHEMES------------
    use {'folke/tokyonight.nvim', config = "require('tokyonight-config')"}
    use {'rose-pine/neovim', as = "rose-pine"} -- add config = "vim.cmd('colorscheme rose-pine')" to make it the default colorscheme
    -------------------UI----------------
    use {"glepnir/dashboard-nvim", config = "require('dashboard-config')"}
    use {'nvim-telescope/telescope.nvim', requires = {{'nvim-lua/plenary.nvim'}}, cmd = "Telescope", config = "require('telescope-config')"}
    -- use { "nvim-telescope/telescope-file-browser.nvim" } -- not working
    use {'akinsho/toggleterm.nvim', config = "require('toggleterm-config')"}
    use {'folke/which-key.nvim', event = "BufWinEnter", config = "require('whichkey-config')"}
    use {'nvim-treesitter/nvim-treesitter', run = ":TSUpdate", config = "require('treesitter-config')"}
    use {'nvim-lualine/lualine.nvim', requires = 'kyazdani42/nvim-web-devicons', event = "BufWinEnter", config = "require('lualine-config')"}
    use {'akinsho/bufferline.nvim', requires = 'kyazdani42/nvim-web-devicons', event = "BufWinEnter", config = "require('bufferline-config')"}
    use {'kyazdani42/nvim-tree.lua', requires = 'kyazdani42/nvim-web-devicons', cmd = "NvimTreeToggle", config = "require('nvim-tree-config')"}
    use {'lewis6991/gitsigns.nvim',
      requires = {'nvim-lua/plenary.nvim'},
      config = function()
        require('gitsigns').setup { current_line_blame = true }
      end,
      event = "BufRead"
    }
    ---------------UI-COLOR--------------
    use {"lukas-reineke/indent-blankline.nvim", event = "BufRead", config = "require('blankline-config')"}
    use {'norcalli/nvim-colorizer.lua', event = "BufRead", config = "require('colorizer-config')"}
    use {'p00f/nvim-ts-rainbow', event = "BufWinEnter", after = "nvim-treesitter"}
    ------------FUNCTIONALITY------------
    use {'windwp/nvim-ts-autotag', event = "InsertEnter", after = "nvim-treesitter"}
    use {'windwp/nvim-autopairs', config = "require('autopairs-config')", after = "nvim-cmp"}
    use {'terrortylor/nvim-comment', config = "require('comment-config')", after = "which-key.nvim"}
    ----------COMPLETIONS & LSP----------
    use {"neovim/nvim-lspconfig", config = "require('lsp')"}
    use {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim"
    }
    use {"hrsh7th/cmp-nvim-lsp"}
    use {"hrsh7th/cmp-buffer"}
    use {"hrsh7th/cmp-path"}
    use {"hrsh7th/nvim-cmp"}
    use {"hrsh7th/cmp-vsnip"}
    use {"hrsh7th/vim-vsnip"} -- changed vsnip_snippet_dir in options/init.lua
    use {"rafamadriz/friendly-snippets", after = "nvim-cmp"}
    use {"onsails/lspkind.nvim"}
    use {"glepnir/lspsaga.nvim", config = "require('lspsaga-config')"}
    use {"jose-elias-alvarez/null-ls.nvim", config = "require('null-ls-config')"}
    ----------------OTHER----------------
    use {"vimwiki/vimwiki", branch = "dev",
      -- keys = { "<leader>x" },
      config = function()
        vim.g["vimwiki_list"] = {
          {
            template_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/vimwiki/autoload/",
            path = '~/dox/Mywiki/'
            --syntax = "markdown", ext = ".md"
          }
        }
        vim.g["vimwiki_global_ext"] = 0
      end
    }
    use {"xuhdev/vim-latex-live-preview", config = "require('vim-latex-live-preview-config')", {['for'] = 'tex'}}
    use {"lervag/vimtex", config = "require('vimtex-config')"}
    ----------------FUN------------------
    use {"eandrju/cellular-automaton.nvim", cmd = "CellularAutomaton"}
    use {"ThePrimeagen/vim-be-good", cmd = "VimBeGood"}
    ----------------END------------------
  end,
  config = {
    display = {
      --open_fn = require("packer.util").float, --double boarders
      -- open_fn = function()
      --   return require('packer.util').float({ border = 'single' })
      -- end
      open_fn = function()
        local result, win, buf = require('packer.util').float {
          border = {
            { '╭', 'FloatBorder' },
            { '─', 'FloatBorder' },
            { '╮', 'FloatBorder' },
            { '│', 'FloatBorder' },
            { '╯', 'FloatBorder' },
            { '─', 'FloatBorder' },
            { '╰', 'FloatBorder' },
            { '│', 'FloatBorder' },
          },
        }
        vim.api.nvim_win_set_option(win, 'winhighlight', 'NormalFloat:Normal')
        return result, win, buf
      end,
    }
  }
})
