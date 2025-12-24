return {
	{
		"RRethy/base16-nvim",
		lazy = false, -- Load the colorscheme immediately at startup
		priority = 1000, -- Ensure it loads before other plugins that depend on colorschemes
	},
	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = nixCats.cats.colorscheme.stylix,
		},
	},
	{
		"tribela/transparent.nvim",
		event = "VimEnter",
		opts = {},
	},
}
