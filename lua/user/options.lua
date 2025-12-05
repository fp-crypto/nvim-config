local options = {
	mouse = "a", -- allow the mouse to be used in neovim
	cursorline = true, -- highlight the current line
	number = true, -- set numbered lines
	relativenumber = true, -- set relative numbered lines
	clipboard = "unnamedplus", -- allows neovim to access the system clipboard
	completeopt = { "menuone", "noselect" }, -- mostly just for cmp
	conceallevel = 0, -- so that `` is visible in markdown files
	showmode = false, -- we don't need to see things like -- INSERT -- anymore
	showtabline = 2, -- always show tabs
	termguicolors = true, -- set term gui colors
	--timeoutlen = 200,                        -- time to wait for a mapped sequence to complete (in milliseconds)
	undofile = true, -- enable persistent undo
	updatetime = 300, -- faster completion (4000ms default)
	expandtab = true, -- convert tabs to spaces
	shiftwidth = 2, -- the number of spaces inserted for each indentation
	tabstop = 2, -- insert 2 spaces for a tab

	backspace = { "indent", "eol", "start" },

	list = true,
}

for k, v in pairs(options) do
	vim.opt[k] = v
end

vim.opt.listchars:append("space:·")

-- local g_options = {
-- 	vim_json_conceal = 0,
-- 	indentLine_setConceal = 0,
-- }
--
-- for k, v in pairs(g_options) do
-- 	vim.g[k] = v
-- end
