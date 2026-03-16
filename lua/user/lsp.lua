require("mason").setup()

local mr = require("mason-registry")
for _, name in ipairs({ "tree-sitter-cli" }) do
	local pkg = mr.get_package(name)
	if not pkg:is_installed() then
		pkg:install()
	end
end
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

vim.lsp.config("*", {
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
})

vim.lsp.config("lua_ls", {
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
				library = vim.api.nvim_get_runtime_file("", true),
			},
			telemetry = {
				enable = false,
			},
		},
	},
	on_attach = function(client, _)
		client.server_capabilities.document_formatting = false
	end,
})

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
