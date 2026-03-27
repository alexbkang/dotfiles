return {
	{
		"ibhagwan/fzf-lua",
		keys = {
			{
				"<leader>ff",
				function()
					require("fzf-lua").vcs_files({ winopts = { title = " Files " } })
				end,
				desc = "Project files (VCS)",
			},
			{
				"<leader>fF",
				function()
					require("fzf-lua").files()
				end,
				desc = "All files",
			},
			{
				"<leader>fb",
				function()
					require("fzf-lua").buffers()
				end,
				desc = "Buffers",
			},
			{
				"<leader>fo",
				function()
					require("fzf-lua").oldfiles()
				end,
				desc = "Recent files",
			},
			{
				"<leader>fg",
				function()
					require("fzf-lua").live_grep()
				end,
				desc = "Live grep (project)",
			},
			{
				"<leader>fh",
				function()
					require("fzf-lua").helptags()
				end,
				desc = "Help tags",
			},
			{
				"<leader>fc",
				function()
					require("fzf-lua").commands()
				end,
				desc = "Commands",
			},
			{
				"<leader>fk",
				function()
					require("fzf-lua").keymaps()
				end,
				desc = "Keymaps",
			},
			{
				"<leader>gb",
				function()
					require("fzf-lua").git_branches()
				end,
				desc = "Git branches",
			},
		},
		opts = {},
	},
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"mfussenegger/nvim-dap-python",
			"leoluz/nvim-dap-go",
		},
		keys = {
			{
				"<leader>dc",
				function()
					require("dap").continue()
				end,
				desc = "DAP continue",
			},
			{
				"<leader>dn",
				function()
					require("dap").step_over()
				end,
				desc = "DAP step over",
			},
			{
				"<leader>di",
				function()
					require("dap").step_into()
				end,
				desc = "DAP step into",
			},
			{
				"<leader>do",
				function()
					require("dap").step_out()
				end,
				desc = "DAP step out",
			},
			{
				"<leader>db",
				function()
					require("dap").toggle_breakpoint()
				end,
				desc = "DAP breakpoint",
			},
			{
				"<leader>dB",
				function()
					require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
				end,
				desc = "DAP cond breakpoint",
			},
			{
				"<leader>dr",
				function()
					require("dap").repl.toggle()
				end,
				desc = "DAP REPL",
			},
			{
				"<leader>dl",
				function()
					require("dap").run_last()
				end,
				desc = "DAP run last",
			},
			{
				"<leader>dt",
				function()
					require("dap").terminate()
				end,
				desc = "DAP terminate",
			},
		},
	},
	{
		"igorlfs/nvim-dap-view",
		lazy = false,
		version = "1.*",
		keys = {
			{ "<leader>dd", "<cmd>DapViewToggle<cr>", desc = "DAP view toggle" },
		},
		opts = {},
	},
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",
			"nvim-neotest/neotest-python",
			"fredrikaverpil/neotest-golang",
			"nvim-neotest/neotest-plenary",
		},
		keys = {
			{ "<leader>tr", "<cmd>Neotest run<cr>" },
			{ "<leader>to", "<cmd>Neotest output<cr>" },
			{ "<leader>ts", "<cmd>Neotest summary<cr>" },
			{ "<leader>tR", "<cmd>lua require('neotest').run.run({ suite = true })<cr>" },
		},
		config = function()
			require("neotest").setup({
				settings = {
					watch = true,
				},
				adapters = {
					require("neotest-python"),
					require("neotest-golang"),
					require("neotest-plenary"),
				},
			})
		end,
	},
	{
		"ldelossa/gh.nvim",
		dependencies = {
			{
				"ldelossa/litee.nvim",
				config = function()
					require("litee.lib").setup()
				end,
			},
		},
		config = function()
			require("litee.gh").setup()
		end,
	},
	{
		"kdheepak/lazygit.nvim",
		lazy = true,
		cmd = {
			"LazyGit",
			"LazyGitConfig",
			"LazyGitCurrentFile",
			"LazyGitFilter",
			"LazyGitFilterCurrentFile",
		},
		init = function()
			vim.g.lazygit_floating_window_scaling_factor = 1.0
			vim.g.lazygit_floating_window_border_chars = {
				"┌",
				"─",
				"┐",
				"│",
				"┘",
				"─",
				"└",
				"│",
			}
		end,
		keys = {
			{ "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
		},
	},
}
