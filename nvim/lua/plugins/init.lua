return require('packer').startup({
  function(use)
  -- Packer can manage itself
  use {'wbthomason/packer.nvim'}
  -------------COLORSCHEMES------------
  use { 'folke/tokyonight.nvim', config = "vim.cmd('colorscheme tokyonight-night')" }
  --use { 'rose-pine/neovim', config = "vim.cmd('colorscheme rose-pine')" }
  -------------------UI----------------
  use {'glepnir/dashboard-nvim'}
  use {'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  use {'folke/which-key.nvim'}
  use {'junegunn/goyo.vim'}
  use {'nvim-treesitter/nvim-treesitter', run = ":TSUpdate"}
  use {'kyazdani42/nvim-tree.lua', requires = {
      'kyazdani42/nvim-web-devicons'},
      config = function() require'nvim-tree'.setup {} end}
  use {'nvim-lualine/lualine.nvim',
      requires = {'kyazdani42/nvim-web-devicons'}}
  use {'akinsho/bufferline.nvim',
      requires = 'kyazdani42/nvim-web-devicons'}
  use {'lewis6991/gitsigns.nvim',
    requires = {'nvim-lua/plenary.nvim'},
    config = function()
      require('gitsigns').setup{current_line_blame = true}
    end
  }
  ---------------UI-COLOR--------------
  use {"lukas-reineke/indent-blankline.nvim"}
  use {'norcalli/nvim-colorizer.lua'}
  use {'p00f/nvim-ts-rainbow'}
  ------------FUNCTIONALITY------------
  use {'windwp/nvim-ts-autotag'}
  use {'windwp/nvim-autopairs'}
  -------------COMPLETIONS-------------
  use "neovim/nvim-lspconfig"
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-buffer"
  use "hrsh7th/cmp-path"
  use "hrsh7th/cmp-vsnip"
  use "hrsh7th/nvim-cmp"
  use "hrsh7th/vim-vsnip"
  use "onsails/lspkind.nvim"
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
  use {'xuhdev/vim-latex-live-preview', {['for'] = 'tex'}}
  use {'lervag/vimtex'}
  end,
  config = {
    display = {
      --open_fn = require("packer.util").float, --double boarders
      open_fn = function()
        return require('packer.util').float({ border = 'single' })
      end
    }
  }
})
