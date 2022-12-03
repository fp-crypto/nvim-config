require("lualine").setup({
	options = {
		theme = "auto",
		disabled_filetypes = {
			statusline = { "NvimTree" },
			tabline = { "NvimTree" },
		},
	},
	tabline = {
		lualine_a = {
			{
				"buffers",
				filetype_names = {
					NvimTree = "NvimTree",
				},
			},
		},
		lualine_b = {},
		lualine_c = {},
		lualine_x = {},
		lualine_y = {},
		lualine_z = { "tabs" },
	},
})
