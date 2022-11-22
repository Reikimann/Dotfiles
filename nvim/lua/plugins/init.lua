return require('packer').startup(function()
    -- Packer can manage itself
    use {'wbthomason/packer.nvim'}
    use {'folke/tokyonight.nvim'}
    use {'sam4llis/nvim-tundra'}
    use {'nvim-treesitter/nvim-treesitter', run = ":TSUpdate"}
    use {'nvim-lualine/lualine.nvim', 
        requires = {'kyazdani42/nvim-web-devicons'}}
    use {'akinsho/bufferline.nvim', 
        requires = 'kyazdani42/nvim-web-devicons'}
    use {'kyazdani42/nvim-tree.lua', requires = {
        'kyazdani42/nvim-web-devicons'}, 
        config = function() require'nvim-tree'.setup {} end}
    use {'windwp/nvim-ts-autotag'}
    use {'p00f/nvim-ts-rainbow'}
    use {'windwp/nvim-autopairs'}
    use {'folke/which-key.nvim'}
    use {'junegunn/goyo.vim'}
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
    use {'lervag/vimtex'}
    use {'xuhdev/vim-latex-live-preview', {['for'] = 'tex'}}
    use {'nvim-telescope/telescope.nvim',
      requires = { {'nvim-lua/plenary.nvim'} }
    }
    use {'norcalli/nvim-colorizer.lua'}
    use {'lewis6991/gitsigns.nvim',
      requires = {'nvim-lua/plenary.nvim'},
      config = function()
        require('gitsigns').setup{current_line_blame = true}
      end
    }
    use {'glepnir/dashboard-nvim'}
end)
