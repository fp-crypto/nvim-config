require("nvim-tree").setup({
	filters = {
		dotfiles = true,
		custom = {},
		exclude = {},
	},
})

-- autoclose
-- vim.api.nvim_create_autocmd("BufEnter", {
-- 	group = vim.api.nvim_create_augroup("NvimTreeClose", { clear = true }),
-- 	pattern = "NvimTree_*",
-- 	callback = function()
-- 		local layout = vim.api.nvim_call_function("winlayout", {})
-- 		if
-- 			layout[1] == "leaf"
-- 			and vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(layout[2]), "filetype") == "NvimTree"
-- 			and layout[3] == nil
-- 		then
-- 			vim.cmd("confirm quit")
-- 		end
-- 	end,
-- })

vim.api.nvim_create_autocmd("BufEnter", {
	nested = true,
	callback = function()
		local api = require("nvim-tree.api")

		-- Only 1 window with nvim-tree left: we probably closed a file buffer
		if #vim.api.nvim_list_wins() == 1 and api.tree.is_tree_buf() then
			-- Required to let the close event complete. An error is thrown without this.
			vim.defer_fn(function()
				-- close nvim-tree: will go to the last hidden buffer used before closing
				api.tree.toggle({ find_file = true, focus = true })
				-- re-open nivm-tree
				api.tree.toggle({ find_file = true, focus = true })
				-- nvim-tree is still the active window. Go to the previous window.
				vim.cmd("wincmd p")
			end, 0)
		end
	end,
})
