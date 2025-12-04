local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	-- Editor UI
	{ import = "prabs.plugins.tokyonight" },
	{ import = "prabs.plugins.lualine" },
	{ import = "prabs.plugins.neo-tree" },
	{ import = "prabs.plugins.lsp-file-operations" },
	{ import = "prabs.plugins.alpha" },
	-- Text Editing
	{ "tpope/vim-surround" },
	{ "tpope/vim-commentary" },
	{ import = "prabs.plugins.treesj" },
	{ "tpope/vim-sleuth" },
	{ "tpope/vim-repeat" },
	{ "wellle/targets.vim" },
	{ import = "prabs.plugins.autopairs" },
	{ import = "prabs.plugins.project" },
	{ "github/copilot.vim" },
	-- Git support
	{ "tpope/vim-fugitive",               dependencies = "tpope/vim-rhubarb" },
	-- Debugging
	{ import = "prabs.plugins.dap" },
	-- Syntax highlighting
	{ import = "prabs.plugins.treesitter" },
	-- Search
	{ import = "prabs.plugins.telescope" },
	-- Autocomplete
	{ import = "prabs.plugins.cmp" },
	-- Language servers
	{ import = "prabs.plugins.lspconfig" },
	-- Formatting
	{ import = "prabs.plugins.conform" },
	-- Linting
	{ import = "prabs.plugins.lint" },
})
