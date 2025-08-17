return {
	{
		"svalaskevicius/nerdcommenter",
		lazy = true,
		init = function()
			vim.g.NERDCreateDefaultMappings = 0
			vim.g.NERDDefaultAlign = "left"
			vim.g.NERDCommentEmptyLines = 1
			vim.g.NERDSpaceDelims = 1
		end,
		keys = function()
			return require("fredrik.config.keymaps").setup_commenter_keymaps()
		end,
	},
}
