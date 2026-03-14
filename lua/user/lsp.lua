require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = {
		"ty",
		--"pyright",
		"ruff",
		"solidity_ls",
		"lua_ls",
		"vimls",
		"ts_ls",
		"rust_analyzer",
		"yamlls",
		"tombi", -- toml
		"dockerls",
	},
	automatic_enable = true,
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()

local lspcfg = vim.lsp.config

lspcfg("ty", {})
--lspcfg("pyright", {
--	capabilities = capabilities,
--	settings = {
--		pyright = {
--			-- Using Ruff's import organizer
--			disableOrganizeImports = true,
--		},
--		python = {
--			analysis = {
--				-- Ignore all files for analysis to exclusively use Ruff for linting
--				-- ignore = { "*" },
--			},
--		},
--	},
--})
lspcfg("ruff", {})
lspcfg("solidity_ls", {})
lspcfg("lua_ls", {
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
				path = {
					"lua/?.lua",
					"lua/?/init.lua",
				},
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
lspcfg("vimls", {})
lspcfg("ts_ls", {})
lspcfg("rust_analyzer", {})
lspcfg("yamlls", {})
lspcfg("tombi", {})
lspcfg("dockerls", {})

-- Native document highlighting (replaces vim-illuminate)
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client and client.server_capabilities.documentHighlightProvider then
			local group = vim.api.nvim_create_augroup("lsp_document_highlight", { clear = false })
			vim.api.nvim_clear_autocmds({ group = group, buffer = args.buf })
			vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
				group = group,
				buffer = args.buf,
				callback = vim.lsp.buf.document_highlight,
			})
			vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
				group = group,
				buffer = args.buf,
				callback = vim.lsp.buf.clear_references,
			})
		end
	end,
})
