-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- -- Make sure to setup `mapleader` and `maplocalleader` before
-- -- loading lazy.nvim so that mappings are correct.
-- -- This is also a good place to setup other settings (vim.opt)
-- vim.g.mapleader = " "
-- vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
		-- Plugin Mangager

		-- Install treesitter
		{
			"nvim-treesitter/nvim-treesitter",
			build = ":TSUpdate",
			dependencies = {
				{
					"hiphish/rainbow-delimiters.nvim",
					submodules = false,
				},
				{ "nvim-treesitter/playground" },
				{ "windwp/nvim-autopairs" },
			},
			event = { "VeryLazy" },
			lazy = vim.fn.argc(-1) == 0,
			init = function(plugin)
				-- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
				-- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
				-- no longer trigger the **nvim-treesitter** module to be loaded in time.
				-- Luckily, the only things that those plugins need are the custom queries, which we make available
				-- during startup.
				require("lazy.core.loader").add_to_rtp(plugin)
				require("nvim-treesitter.query_predicates")
			end,
			cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
		},

		-- theme
		{
			"folke/tokyonight.nvim",
			lazy = false, -- make sure we load this during startup if it is your main colorscheme
			priority = 1000, -- make sure to load this before all the other start plugins
			config = function()
				-- load the colorscheme here
				vim.cmd([[colorscheme tokyonight]])
			end,
		},

		{ "kyazdani42/nvim-web-devicons" },
		{ "kyazdani42/nvim-tree.lua" },

		{ "nvim-mini/mini.icons" },

		{ "nvim-lualine/lualine.nvim" },
		--{ "kdheepak/tabline.nvim" },
		--use {'akinsho/bufferline.nvim', requires = 'kyazdani42/nvim-web-devicons'}
		{
			"folke/snacks.nvim",
			priority = 1000,
			lazy = false,
			---@type snacks.Config
			opts = {
				bigfile = { enabled = true },
				indent = { enabled = true },
				gitbrowse = { enabled = true },
				picker = { enabled = true },
				scope = { enabled = true },
				scroll = { enabled = true },
				words = { enabled = true },
			},
		},

		-- git stuff
		{ "tpope/vim-fugitive" },
		{ "tpope/vim-rhubarb" },
		{ "lewis6991/gitsigns.nvim" },

		-- smart contract dev
		{ "TovarishFin/vim-solidity" },
		{ "vyperlang/vim-vyper" },
		--use({ "starkware-libs/cairo-lang", rtp = "src/starkware/cairo/lang/ide/vim" })
		--
		{ "nvim-lua/plenary.nvim" },
		{ "nvim-lua/popup.nvim" },

		{
			"andythigpen/nvim-coverage",
			config = function()
				require("coverage").setup()
			end,
		},

		-- Install Lsp Stuff
		{
			"mason-org/mason.nvim",
			"mason-org/mason-lspconfig.nvim",
			"neovim/nvim-lspconfig",
		},

		-- Install nvim-cmp
		{
			"hrsh7th/nvim-cmp",
			-- load cmp on InsertEnter
			-- event = "InsertEnter",
			-- these dependencies will only be loaded when cmp loads
			-- dependencies are always lazy-loaded unless specified otherwise
			dependencies = {
				"hrsh7th/cmp-nvim-lsp",
				"hrsh7th/cmp-buffer",
				"hrsh7th/cmp-path",
			},
		},

		{ "saadparwaiz1/cmp_luasnip" },
		{
			"L3MON4D3/LuaSnip",
			-- follow latest release.
			version = "v2.*",
			-- install jsregexp (optional!).
			build = "make install_jsregexp",
		},
		{ "rafamadriz/friendly-snippets" },
		{ "nvimtools/none-ls.nvim" },

		{
			"folke/lazydev.nvim",
			ft = "lua", -- only load on lua files
			opts = {
				library = {
					-- See the configuration section for more details
					-- Load luvit types when the `vim.uv` word is found
					{ path = "luvit-meta/library", words = { "vim%.uv" } },
				},
			},
		},
		{ "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings

		{ "RRethy/vim-illuminate" },

		-- Install dap
		{ "mfussenegger/nvim-dap" },
		{ "rcarriga/nvim-dap-ui" },
		{ "theHamsta/nvim-dap-virtual-text" },
		{ "mfussenegger/nvim-dap-python" },

		-- Keybinding
		{
			"folke/which-key.nvim",
			event = "VeryLazy",
			config = function()
				vim.o.timeout = true
				vim.o.timeoutlen = 300
				require("which-key").setup({
					-- your configuration comes here
					-- or leave it empty to use the default settings
				})
			end,
		},

		{ "folke/trouble.nvim" },

		-- Surround text objects (sa/sd/sr)
		{ "echasnovski/mini.surround", version = "*", config = true },

		-- Quick commenting (gcc/gc)
		{ "numToStr/Comment.nvim", config = true },

		-- Fast navigation (s/S)
		{
			"folke/flash.nvim",
			event = "VeryLazy",
			opts = {},
			keys = {
				{ "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
				{ "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
			},
		},

		{
			"MeanderingProgrammer/render-markdown.nvim",
			opts = {
				file_types = { "markdown", "Avante" },
			},
			ft = { "markdown", "Avante" },
			lazy = true,
		},

		-- {
		-- 	"benlubas/molten-nvim",
		-- 	version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
		-- 	dependencies = {
		-- 		{
		-- 			-- see the image.nvim readme for more information about configuring this plugin
		-- 			"3rd/image.nvim",
		-- 			opts = {
		-- 				backend = "kitty", -- whatever backend you would like to use
		-- 				max_width = 100,
		-- 				max_height = 12,
		-- 				max_height_window_percentage = math.huge,
		-- 				max_width_window_percentage = math.huge,
		-- 				window_overlap_clear_enabled = true, -- toggles images when windows are overlapped
		-- 				window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
		-- 			},
		-- 		},
		-- 	},
		-- 	build = ":UpdateRemotePlugins",
		-- 	init = function()
		-- 		-- these are examples, not defaults. Please see the readme
		-- 		vim.g.molten_image_provider = "image.nvim"
		-- 		vim.g.molten_output_win_max_height = 20
		-- 	end,
		-- },

		-- {
		-- 	"yetone/avante.nvim",
		-- 	event = "VeryLazy",
		-- 	lazy = false,
		-- 	version = false, -- set this if you want to always pull the latest change
		-- 	opts = {
		-- 		-- add any opts here
		-- 	},
		-- 	build = "make",
		-- 	dependencies = {
		-- 		"nvim-treesitter/nvim-treesitter",
		-- 		"stevearc/dressing.nvim",
		-- 		"nvim-lua/plenary.nvim",
		-- 		"MunifTanjim/nui.nvim",
		-- 		--- The below dependencies are optional,
		-- 		"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
		-- 		"zbirenbaum/copilot.lua", -- for providers='copilot'
		-- 		{
		-- 			-- support for image pasting
		-- 			"HakonHarnes/img-clip.nvim",
		-- 			event = "VeryLazy",
		-- 			opts = {
		-- 				-- recommended settings
		-- 				default = {
		-- 					embed_image_as_base64 = false,
		-- 					prompt_for_file_name = false,
		-- 					drag_and_drop = {
		-- 						insert_mode = true,
		-- 					},
		-- 					-- required for Windows users
		-- 					use_absolute_path = true,
		-- 				},
		-- 			},
		-- 		},
		-- 		{
		-- 			-- Make sure to set this up properly if you have lazy=true
		-- 			"MeanderingProgrammer/render-markdown.nvim",
		-- 			opts = {
		-- 				file_types = { "markdown", "Avante" },
		-- 			},
		-- 			ft = { "markdown", "Avante" },
		-- 		},
		-- 	},
		-- },
	},
	-- Configure any other settings here. See the documentation for more details.
	-- colorscheme that will be used when installing plugins.
	install = { colorscheme = { "habamax" } },
	-- automatically check for plugin updates
	checker = { enabled = true },
})
