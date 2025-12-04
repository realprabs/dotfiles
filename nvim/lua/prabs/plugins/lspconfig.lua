return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		"b0o/schemastore.nvim",
		{ "folke/lazydev.nvim", ft = "lua", opts = {} },
	},
	config = function()
		-- Setup Mason to automatically install LSP servers
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		require("mason").setup()

		require("mason-tool-installer").setup({
			ensure_installed = {
				-- LSP servers
				"lua-language-server",
				"typescript-language-server",
				"html-lsp",
				"css-lsp",
				"intelephense",
				"ruby-lsp",
				-- Formatters
				"stylua",
				"prettierd",
				"rubocop",
				"php-cs-fixer",
				-- Linters
				"eslint_d",
				"phpstan",
			},
		})

		require("mason-lspconfig").setup({
			automatic_installation = true,
			handlers = {
				-- Default handler for all servers
				function(server_name)
					require("lspconfig")[server_name].setup({
						capabilities = capabilities,
					})
				end,
				-- Custom handler for jsonls
				jsonls = function()
					require("lspconfig").jsonls.setup({
						capabilities = capabilities,
						settings = {
							json = {
								schemas = require("schemastore").json.schemas(),
								validate = { enable = true },
							},
						},
					})
				end,
				-- Custom handler for lua_ls
				lua_ls = function()
					require("lspconfig").lua_ls.setup({
						capabilities = capabilities,
						settings = {
							Lua = {
								workspace = { checkThirdParty = false },
								telemetry = { enable = false },
							},
						},
					})
				end,
			},
		})

		-- Keymaps
		vim.keymap.set("n", "<Leader>d", "<cmd>lua vim.diagnostic.open_float()<CR>")
		vim.keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>")
		vim.keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>")
		vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
		vim.keymap.set("n", "gi", ":Telescope lsp_implementations<CR>")
		vim.keymap.set("n", "gr", ":Telescope lsp_references<CR>")
		vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
		vim.keymap.set({ "n", "i" }, "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
		vim.keymap.set("n", "<Leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>")
		vim.keymap.set("n", "<Leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>")

		-- Diagnostic configuration
		vim.diagnostic.config({
			virtual_text = false,
			float = {
				source = true,
			},
		})
	end,
}
