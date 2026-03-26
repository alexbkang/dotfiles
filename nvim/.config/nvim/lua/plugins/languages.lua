return {
	{
		"saghen/blink.cmp",
		dependencies = { "rafamadriz/friendly-snippets" },
		version = "1.*",
		config = function()
			require("blink.cmp").setup({})
		end,
	},
	{
		"stevearc/conform.nvim",
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					lua = { "stylua" },
					python = { "isort", "black" },
				},
				format_on_save = {
					timeout_ms = 500,
					lsp_format = "fallback",
				},
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter").install({ "python", "go", "lua" })
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "python", "go", "lua" },
				callback = function()
					vim.treesitter.start()
				end,
			})
		end,
	},
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {
			ensure_installed = { "pyright", "gopls", "lua_ls" },
		},
		dependencies = {
			{
				"mason-org/mason.nvim",
				opts = {
					ui = {
						width = 1,
						height = 1,
					},
				},
			},
			{
				"neovim/nvim-lspconfig",
				keys = {
					{ "ga", vim.lsp.buf.code_action, desc = "Code action" },
					{ "gi", vim.lsp.buf.implementation, desc = "Go to implementation" },
					{ "gn", vim.lsp.buf.rename, desc = "Rename symbol" },
					{ "gr", vim.lsp.buf.references, desc = "Find references" },
					{ "gt", vim.lsp.buf.type_definition, desc = "Go to type definition" },
					{ "gd", vim.lsp.buf.definition, desc = "Go to definition" },
					{ "K", vim.lsp.buf.hover, desc = "Hover info" },
					{ "gD", vim.lsp.buf.declaration, desc = "Go to declaration" },
				},
			},
		},
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "mason-org/mason.nvim" },
		opts = {
			ensure_installed = { "stylua", "isort", "black" },
		},
	},
}
