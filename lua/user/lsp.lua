require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {
    "pyright",
    "ruff",
    "solidity_ls",
    "lua_ls",
    "vimls",
    "ts_ls",
    "rust_analyzer",
    "yamlls",
    "taplo", -- toml
    "dockerls",
  },
  automatic_enable = true,
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()

local lspcfg = vim.lsp.config

lspcfg('pyright', {
  capabilities = capabilities,
  settings = {
    pyright = {
      -- Using Ruff's import organizer
      disableOrganizeImports = true,
    },
    python = {
      analysis = {
        -- Ignore all files for analysis to exclusively use Ruff for linting
        -- ignore = { "*" },
      },
    },
  },
})
lspcfg('ruff', {})
lspcfg('solidity_ls', {})
lspcfg('lua_ls', {
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      telemetry = {
        enable = false,
      },
      capabilities = capabilities,
    },
  },
  on_attach = function(
      client,
      _ --[[buffer--]]
  )
    client.server_capabilities.document_formatting = false -- don't use semneko formatting
  end,
})
lspcfg('vimls', {})
lspcfg('ts_ls', {})
lspcfg('rust_analyzer', {})
lspcfg('yamlls', {})
lspcfg('taplo', {})
lspcfg('dockerls', {})
