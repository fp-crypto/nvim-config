require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = {
		"pyright",
		"solidity",
		"lua_ls",
		"vimls",
		"tsserver",
		"rust_analyzer",
		"yamlls",
	},
})

local lspcfg = require("lspconfig")

lspcfg.pyright.setup({})
lspcfg.solidity_ls.setup({})
lspcfg.lua_ls.setup({
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
lspcfg.rust_analyzer.setup({})
lspcfg.yamlls.setup({})

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
		diagnostics.solhint.with({
			method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
		}),
		formatting.black,
		diagnostics.hadolint,
	},
})

vim.api.nvim_create_user_command("Format", function(opts)
	vim.lsp.buf.format()
end, { range = true })
-- vim.api.nvim_create_user_command("FormatSelection", function(opts)
--   --vim.pretty_print(opts)
--   vim.lsp.buf.format {range={start={opts.line1,0}, end={opts.line2+1,0}}}
-- end, { range = true })
--vim.cmd([[ command! Format execute 'lua vim.lsp.buf.format()' ]])
--vim.cmd([[ command! FormatSelection execute 'lua vim.lsp.buf.format()' ]])
