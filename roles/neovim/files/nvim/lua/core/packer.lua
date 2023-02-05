local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') ..
      '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1',
      'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'rktjmp/lush.nvim'
  use 'arcticicestudio/nord-vim'
  use 'nvim-tree/nvim-tree.lua'
  use 'nvim-tree/nvim-web-devicons'
  use 'glepnir/galaxyline.nvim'
  use 'nvim-treesitter/nvim-treesitter'
  use 'lukas-reineke/indent-blankline.nvim'
  use 'lewis6991/gitsigns.nvim'
  use 'folke/todo-comments.nvim'
  use 'gpanders/editorconfig.nvim'
  use 'levouh/tint.nvim'
  use 'towolf/vim-helm'
  use {
    'phaazon/hop.nvim',
    branch = 'v2',
  }
  use 'folke/trouble.nvim'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'
  use 'rafamadriz/friendly-snippets'
  use {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
  }
  use {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.0',
    requires = { { 'nvim-lua/plenary.nvim' } }
  }
  use {
    "rcarriga/nvim-dap-ui",
    requires = {
      { "mfussenegger/nvim-dap" },
    }
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
