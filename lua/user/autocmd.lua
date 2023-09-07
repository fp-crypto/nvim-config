local augroup = function(name)
	vim.api.nvim_create_augroup(name, {})
end

local autocmd = vim.api.nvim_create_autocmd

-- numbertoggle: relative lines is normal mode, absolute in insert mode
augroup("numbertoggle")
autocmd({ "BufEnter", "FocusGained", "InsertLeave" }, { group = "numbertoggle", command = "set relativenumber" })
autocmd({ "BufLeave", "FocusLost", "InsertEnter" }, { group = "numbertoggle", command = "set norelativenumber" })

-- cairo detection
augroup("_cairo")
autocmd({ "BufNewFile", "BufRead" }, { pattern = "*.cairo", command = "set filetype=cairo", group = "_cairo" })

-- lua autoformat
augroup("_lua")
autocmd({ "BufWritePre", "FileWritePre" }, { group = "_lua", pattern = "*.lua", command = "Format" })

-- yaml settings
augroup("_yaml")
autocmd("FileType", {
	group = "_yaml",
	pattern = "yaml",
	command = "setlocal ts=2 sts=2 sw=2 expandtab",
})

-- yaml settings
augroup("_solidity")
autocmd("FileType", {
	group = "_solidity",
	pattern = "solidity",
	command = "setlocal ts=4 sts=4 sw=4 expandtab",
})

-- dockerfile conceallevel
augroup("_docker")
autocmd("FileType", {
	group = "_docker",
	pattern = "dockerfile",
	command = "setlocal conceallevel=0",
})
