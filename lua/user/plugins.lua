local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

return require("packer").startup(function(use)
	-- Plugin Mangager
	use("wbthomason/packer.nvim") -- Have packer manage itself

	-- theme
	use("folke/tokyonight.nvim")

	use("kyazdani42/nvim-web-devicons")
	use("kyazdani42/nvim-tree.lua")

	use("lukas-reineke/indent-blankline.nvim")

	use("nvim-lualine/lualine.nvim")
	--use("kdheepak/tabline.nvim")
	--use {'akinsho/bufferline.nvim', requires = 'kyazdani42/nvim-web-devicons'}

	-- git stuff
	use("tpope/vim-fugitive")
	use("tpope/vim-rhubarb")
	use("lewis6991/gitsigns.nvim")

	-- smart contract dev
	use("TovarishFin/vim-solidity")
	use("vyperlang/vim-vyper")
	use({ "starkware-libs/cairo-lang", rtp = "src/starkware/cairo/lang/ide/vim" })

	use("nvim-lua/plenary.nvim")
	use("nvim-lua/popup.nvim")
	use("nvim-telescope/telescope.nvim")

	-- Install Lsp Stuff
	use({
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
	})

	-- Install nvim-cmp
	use({

		"hrsh7th/nvim-cmp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-nvim-lsp",
	})
	use("saadparwaiz1/cmp_luasnip")
	use("L3MON4D3/LuaSnip")
	use("rafamadriz/friendly-snippets")
	use("jose-elias-alvarez/null-ls.nvim")

	-- Install treesitter
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
	use("p00f/nvim-ts-rainbow")
	use("nvim-treesitter/playground")
	use("windwp/nvim-autopairs")

	use("RRethy/vim-illuminate")

	-- Install dap
	use("mfussenegger/nvim-dap")
	use("rcarriga/nvim-dap-ui")
	use("theHamsta/nvim-dap-virtual-text")
	use("mfussenegger/nvim-dap-python")

	-- Keybinding
	use({
		"folke/which-key.nvim",
		config = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
			require("which-key").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
			})
		end,
	})

	use("folke/trouble.nvim")

	-- Want?
	-- use({ "akinsho/toggleterm.nvim", tag = "v2.*" })

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
