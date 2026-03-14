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
keymap("n", "<leader>ft", "<cmd>lua Snacks.picker()<cr>", opts)
keymap("n", "<leader>ff", "<cmd>lua Snacks.picker.files()<cr>", opts)
keymap("n", "<leader>fg", "<cmd>lua Snacks.picker.grep()<cr>", opts)
keymap("n", "<leader>fb", "<cmd>lua Snacks.picker.buffers()<cr>", opts)
keymap("n", "<leader>fh", "<cmd>lua Snacks.picker.help()<cr>", opts)
keymap("n", "<leader>fd", "<cmd>lua Snacks.picker.diagnostics_buffer()<cr>", opts)

keymap("n", "<leader>tt", "<cmd>NvimTreeToggle<cr>", opts)

keymap("n", "<leader>dd", "<cmd>lua vim.diagnostic.open_float()<cr>", opts)
keymap("n", "<leader>dn", "<cmd>lua vim.diagnostic.goto_next()<cr>", opts)
keymap("n", "<leader>dp", "<cmd>lua vim.diagnostic.goto_prev()<cr>", opts)

-- LSP navigation
keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)

-- Toggle quickfix window
vim.keymap.set("n", "<leader>q", function()
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
end, { noremap = true, silent = true, desc = "Toggle quickfix" })

-- <leader>p formatting handled by conform.nvim in lazy.lua
-- "nnoremap <silent> <leader> :WhichKey '<Space>'<CR>
--keymap("n", "<leader>", ":WhichKey <space><cr>", opts)

-- "nnoremap <silent> <leader> :WhichKey '<Space>'<CR>
-- Use ctrl-[hjkl] to select the active split!
keymap("n", "<c-k>", "<cmd>wincmd k<cr>", opts)
keymap("n", "<c-j>", "<cmd>wincmd j<cr>", opts)
keymap("n", "<c-h>", "<cmd>wincmd h<cr>", opts)
keymap("n", "<c-l>", "<cmd>wincmd l<cr>", opts)
