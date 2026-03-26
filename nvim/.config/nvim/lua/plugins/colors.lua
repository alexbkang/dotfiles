local palette = {
	dark2 = "#29292c",
	dark1 = "#29292c",
	background = "#29292c",
	text = "#c3c3c4",
	accent1 = "#b8626a",
	accent2 = "#b98d7b",
	accent3 = "#c4b28a",
	accent4 = "#87a987",
	accent5 = "#8ba4b0",
	accent6 = "#938aa9",
	dimmed1 = "#555854",
	dimmed2 = "#66695f",
	dimmed3 = "#777b74",
	dimmed4 = "#888b85",
	dimmed5 = "#999c96",
}
return {
	{
		"loctvl842/monokai-pro.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("monokai-pro").setup({
				transparent_background = true,
				disabled_plugins = {
					"saghen/blink.cmp",
					"folke/lazy.nvim",
					"mason.nvim",
					"ibhagwan/fzf-lua",
					"nvim-mini/mini.nvim",
				},
				override_palette = function()
					return palette
				end,
			})
			vim.cmd.colorscheme("monokai-pro")
			vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
			vim.api.nvim_set_hl(0, "FloatBorder", { fg = palette.dimmed3, bg = "none" })
			vim.api.nvim_set_hl(0, "FloatTitle", { fg = palette.text, bg = "none" })
			vim.api.nvim_set_hl(0, "Pmenu", { fg = palette.text, bg = "none" })
			vim.api.nvim_set_hl(0, "BlinkCmpMenuBorder", { fg = palette.dimmed3, bg = "none" })
			vim.api.nvim_set_hl(0, "PmenuSel", { link = "CursorLine" })
			vim.api.nvim_set_hl(0, "WinSeparator", { fg = palette.text })
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		opts = {
			options = {
				theme = {
					normal = {
						a = { bg = palette.accent5, fg = palette.background },
						b = { bg = palette.background, fg = palette.dimmed3 },
						c = { bg = palette.background, fg = palette.dimmed3 },
					},
					insert = { a = { bg = palette.accent4, fg = palette.background } },
					visual = { a = { bg = palette.accent6, fg = palette.background } },
					replace = { a = { bg = palette.accent3, fg = palette.background } },
					command = { a = { bg = palette.accent2, fg = palette.background } },
					inactive = {
						a = { bg = palette.background, fg = palette.dimmed3 },
						c = { bg = palette.background, fg = palette.dimmed3 },
					},
				},
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { { "branch", icon = "" }, "diff" },
				lualine_c = { "filename" },
				lualine_x = { "diagnostic", "filetype" },
				lualine_y = {},
				lualine_z = { "location" },
			},
		},
	},
	{
		"nvim-mini/mini.notify",
		version = false,
		opts = {
			window = {
				config = {
					title = "",
				},
				winblend = 0,
			},
			content = {
				format = function(notif)
					return notif.msg
				end,
			},
			lsp_progress = {
				enable = false,
			},
		},
	},
}
