-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
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
      lazy = false,
      priority = 10000, -- must be higher than snacks.nvim (1000)
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
    { "Bilal2453/luvit-meta",           lazy = true }, -- optional `vim.uv` typings

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
    { "numToStr/Comment.nvim",     config = true },

    -- Fast navigation (s/S)
    {
      "folke/flash.nvim",
      event = "VeryLazy",
      opts = {},
      keys = {
        { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end,       desc = "Flash" },
        { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      },
    },

    -- Formatting with range support
    {
      "stevearc/conform.nvim",
      event = { "BufWritePre" },
      cmd = { "ConformInfo" },
      keys = {
        { "<leader>p", function() require("conform").format({ async = true }) end, mode = { "n", "v" }, desc = "Format" },
      },
      opts = {
        formatters_by_ft = {
          lua = { "stylua" },
          python = {
            "ruff_fix",
            "ruff_format",
            "ruff_organize_imports",
          },
          javascript = { "prettier" },
          typescript = { "prettier" },
          solidity = { "prettier" },
        },
        --format_on_save = { timeout_ms = 500, lsp_fallback = true },
      },
    },

    -- Linting
    {
      "mfussenegger/nvim-lint",
      event = { "BufReadPre", "BufNewFile" },
      config = function()
        local lint = require("lint")
        lint.linters_by_ft = {
          solidity = { "solhint" },
          dockerfile = { "hadolint" },
          javascript = { "eslint_d" },
          typescript = { "eslint_d" },
          javascriptreact = { "eslint_d" },
          typescriptreact = { "eslint_d" },
        }

        vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
          callback = function()
            lint.try_lint()
          end,
        })
      end,
    },

    {
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
      lazy = true,
    },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})
