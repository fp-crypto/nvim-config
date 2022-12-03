--vim.g.tokyonight_style = "storm"
vim.g.tokyonight_transparent_sidebar = true

require("tokyonight").setup({
	style = "storm", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
	transparent = true, -- Enable this to disable setting the background color
	terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
	styles = {
		sidebars = "transparent", -- style for sidebars, see below
		float = "dark",
	},
})

vim.cmd([[colorscheme tokyonight]])
