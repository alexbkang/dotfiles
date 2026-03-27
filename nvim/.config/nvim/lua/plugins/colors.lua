return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
		priority = 1000,
		config = function()
			local transparent = true
			local flavour = "frappe"
			require("catppuccin").setup({
				flavour = flavour,
				transparent_background = transparent,
				auto_integrations = true,
			})

			vim.cmd.colorscheme("catppuccin")
			if transparent then
				local pal = require("catppuccin.palettes").get_palette(flavour)
				vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
				vim.api.nvim_set_hl(0, "FloatBorder", { fg = pal.surface2, bg = "none" })
				vim.api.nvim_set_hl(0, "FloatTitle", { fg = pal.surface2, bg = "none" })
			end
			vim.api.nvim_set_hl(0, "NeogitFloatBorder", { link = "FloatBorder" })
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		config = function()
			local function diff_source()
				local gitsigns = vim.b.gitsigns_status_dict
				if gitsigns then
					return {
						added = gitsigns.added,
						modified = gitsigns.changed,
						removed = gitsigns.removed,
					}
				end
			end

			require("lualine").setup({
				options = {
					theme = "auto",
					component_separators = { left = "", right = "" },
					section_separators = { left = "", right = "" },
					refresh = {
						statusline = 100,
					},
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { { "branch", icon = "" }, { "diff", source = diff_source } },
					lualine_c = { "filename" },
					lualine_x = { "diagnostic", "filetype" },
					lualine_y = {},
					lualine_z = { "location" },
				},
			})
		end,
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
