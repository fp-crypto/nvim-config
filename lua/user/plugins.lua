vim.cmd [[

call plug#begin()

Plug 'lifepillar/vim-solarized8'
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }

Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'

Plug 'Yggdroot/indentLine'

Plug 'nvim-lualine/lualine.nvim'
Plug 'kdheepak/tabline.nvim'

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'

Plug 'airblade/vim-gitgutter'
Plug 'Xuyuanp/nerdtree-git-plugin'

Plug 'TovarishFin/vim-solidity'
Plug 'vyperlang/vim-vyper'

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" Install nvim-cmp
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'L3MON4D3/LuaSnip'
Plug 'rafamadriz/friendly-snippets'

" Install treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} 

" Install dap
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'
Plug 'theHamsta/nvim-dap-virtual-text'
Plug 'mfussenegger/nvim-dap-python'

Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }

Plug 'akinsho/toggleterm.nvim', {'tag' : 'v2.*'}


call plug#end()


]]
