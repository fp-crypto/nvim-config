require("nvim-treesitter.configs").setup({
	-- A list of parser names, or "all"
	ensure_installed = {
		"python",
		"solidity",
		"go",
		"vim",
		"lua",
		"yaml",
		"json",
		"javascript",
	},
	prefer_git = true,

	highlight = {
		-- `false` will disable the whole extension
		enable = true,

		-- list of language that will be disabled
		disable = {
			--[["solidity"--]]
		},

		additional_vim_regex_highlighting = { "solidity" },
	},
})

require("rainbow-delimiters.setup").setup({
	strategy = {
		[""] = "rainbow-delimiters.strategy.global",
	},
	query = {
		[""] = "rainbow-delimiters",
	},
})
