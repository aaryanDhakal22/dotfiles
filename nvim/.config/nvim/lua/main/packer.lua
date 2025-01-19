vim.cmd.packadd('packer.nvim')

return require('packer').startup(function(use)
  use ('wbthomason/packer.nvim')
  use 'm4xshen/autoclose.nvim'
  use {
  'nvim-telescope/telescope.nvim', tag = '0.1.8',
-- or                            , branch = '0.1.x',
  requires = { {'nvim-lua/plenary.nvim'} }
}
  use { "catppuccin/nvim", as = "catppuccin"}
  use({
      "folke/trouble.nvim",
      config = function()
          require("trouble").setup {
              icons = false,
          }
  end
  })
  use({"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"})
  use("theprimeagen/harpoon")
  use("mbbill/undotree")
  use("tpope/vim-fugitive")
  use("nvim-treesitter/nvim-treesitter-context");

  use {
		  -- LSP Support
		  {'neovim/nvim-lspconfig'},
		  {'williamboman/mason.nvim'},
		  {'williamboman/mason-lspconfig.nvim'},

		  -- Autocompletion
		  {'hrsh7th/nvim-cmp'},
		  {'hrsh7th/cmp-buffer'},
		  {'hrsh7th/cmp-path'},
		  {'hrsh7th/cmp-nvim-lsp'},
	  }

  use("folke/zen-mode.nvim")
  use("eandrju/cellular-automaton.nvim")

end)
