local opts = { silent = true }
local keymap = vim.keymap.set

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- basic shortcuts
keymap("n", "<leader>d", "<cmd>bd<cr>", opts)
keymap("n", "<leader>so", "<cmd>so %<cr>", opts)
keymap("n", "<Leader>k", "<cmd>bn<cr>", opts)
keymap("n", "<Leader>j", "<cmd>bp<cr>", opts)
keymap("n", "<leader>w", "<cmd>w<cr>", opts)

-- Snacks picker shortcuts
keymap("n", "<leader>ft", function() Snacks.picker() end, opts)
keymap("n", "<leader>ff", function() Snacks.picker.files() end, opts)
keymap("n", "<leader>fg", function() Snacks.picker.grep() end, opts)
keymap("n", "<leader>fb", function() Snacks.picker.buffers() end, opts)
keymap("n", "<leader>fh", function() Snacks.picker.help() end, opts)
keymap("n", "<leader>fd", function() Snacks.picker.diagnostics_buffer() end, opts)

keymap("n", "<leader>tt", "<cmd>NvimTreeToggle<cr>", opts)

keymap("n", "<leader>dd", function() vim.diagnostic.open_float() end, opts)
keymap("n", "<leader>dn", function() vim.diagnostic.goto_next() end, opts)
keymap("n", "<leader>dp", function() vim.diagnostic.goto_prev() end, opts)

-- LSP navigation
keymap("n", "gd", function() vim.lsp.buf.definition() end, opts)
keymap("n", "gD", function() vim.lsp.buf.declaration() end, opts)
keymap("n", "gr", function() vim.lsp.buf.references() end, opts)
keymap("n", "gi", function() vim.lsp.buf.implementation() end, opts)
keymap("n", "K", function() vim.lsp.buf.hover() end, opts)
keymap("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)
keymap("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)

-- Toggle quickfix window
keymap("n", "<leader>q", function()
	local qf_exists = false
	for _, win in pairs(vim.fn.getwininfo()) do
		if win.quickfix == 1 then
			qf_exists = true
			break
		end
	end
	if qf_exists then
		vim.cmd("cclose")
	else
		vim.cmd("copen")
	end
end, { silent = true, desc = "Toggle quickfix" })

-- Use ctrl-[hjkl] to select the active split!
keymap("n", "<c-k>", "<cmd>wincmd k<cr>", opts)
keymap("n", "<c-j>", "<cmd>wincmd j<cr>", opts)
keymap("n", "<c-h>", "<cmd>wincmd h<cr>", opts)
keymap("n", "<c-l>", "<cmd>wincmd l<cr>", opts)
