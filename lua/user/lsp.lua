local lspcfg = require("lspconfig")

lspcfg.pyright.setup({})
lspcfg.solidity_ls.setup({})
lspcfg.sumneko_lua.setup({
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
		},
	},
	on_attach = function(
		client,
		_ --[[buffer--]]
	)
		client.server_capabilities.document_formatting = false -- don't use semneko formatting
	end,
})
lspcfg.vimls.setup({})
lspcfg.tsserver.setup({})

local null_ls = require("null-ls")
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
--local completion = null_ls.builtins.completion

require("null-ls").setup({
	sources = {
		formatting.stylua,
		formatting.prettier.with({
			extra_filetypes = { "solidity" },
		}),
		diagnostics.solhint,
		formatting.black,
	},
})

vim.cmd([[ command! Format execute 'lua vim.lsp.buf.format()' ]])
--vim.cmd([[ command! FormatSelection execute 'lua vim.lsp.buf.format()' ]])
