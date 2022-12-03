local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- basic shortcuts
keymap("n", "<leader>d", ":bd<cr>", opts)
keymap("n", "<leader>so", ":so %<cr>", opts)
keymap("n", "<Leader>k", ":bn<cr>", opts)
keymap("n", "<Leader>j", ":bp<cr>", opts)
keymap("n", "<leader>w", ":w<cr>", opts)

-- Telescope shortcuts
keymap("n", "<leader>ft", "<cmd>Telescope<cr>", opts)
keymap("n", "<leader>ff", "<cmd>Telescope find_files<cr>", opts)
keymap("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", opts)
keymap("n", "<leader>fb", "<cmd>Telescope buffers<cr>", opts)
keymap("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", opts)
keymap("n", "<leader>fd", "<cmd>Telescope diagnostics<cr>", opts)

keymap("n", "<leader>tt", "<cmd>NvimTreeToggle<cr>", opts)

keymap("n", "<leader>dd", "<cmd>lua vim.diagnostic.open_float()<cr>", opts)
keymap("n", "<leader>dn", "<cmd>lua vim.diagnostic.goto_next()<cr>", opts)
keymap("n", "<leader>dp", "<cmd>lua vim.diagnostic.goto_next()<cr>", opts)

keymap("n", "<leader>p", ":Format<cr>", opts)
keymap("v", "<leader>p", ":FormatSelection<cr>", opts)
-- "nnoremap <silent> <leader> :WhichKey '<Space>'<CR>
