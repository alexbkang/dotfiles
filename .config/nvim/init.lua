-- Options
vim.opt.guicursor = "n-v-c-i:block"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.wrap = false
vim.opt.scrolloff = 10
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.fillchars = "eob: "
vim.opt.clipboard = "unnamedplus"
vim.opt.undofile = true
vim.opt.undolevels = 10000
vim.opt.shortmess:append("I")
vim.opt.laststatus = 3
vim.opt.cmdheight = 0
vim.opt.winborder = "single"
vim.opt.winblend = 0
vim.opt.pumblend = 0

local aug = vim.api.nvim_create_augroup("CustomAutocmds", { clear = true })
vim.api.nvim_create_autocmd("FocusGained", {
	group = aug,
	desc = "Reload files when we focus vim",
	callback = function()
		if vim.fn.getcmdwintype() == "" then
			vim.cmd.checktime()
		end
	end,
})
vim.api.nvim_create_autocmd("BufEnter", {
	group = aug,
	desc = "Check unmodified buffers for disk changes on entry",
	callback = function()
		if vim.bo.buftype == "" and not vim.bo.modified and vim.fn.expand("%") ~= "" then
			vim.cmd.checktime(vim.api.nvim_get_current_buf())
		end
	end,
})

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.diagnostic.config({
	signs = false,
	virtual_text = true,
})

-- Misc keymaps
vim.keymap.set({ "n", "v", "i" }, "<ScrollWheelUp>", "<Nop>")
vim.keymap.set({ "n", "v", "i" }, "<ScrollWheelDown>", "<Nop>")
vim.keymap.set({ "n", "v", "i" }, "<ScrollWheelLeft>", "<Nop>")
vim.keymap.set({ "n", "v", "i" }, "<ScrollWheelRight>", "<Nop>")

-- Plugins
local pack_hooks = function(ev)
	local name, kind = ev.data.spec.name, ev.data.kind
	if name == "nvim-treesitter" and (kind == "install" or kind == "update") then
		if not ev.data.active then
			vim.cmd.packadd("nvim-treesitter")
		end
		vim.cmd("TSUpdate")
	end
end
vim.api.nvim_create_autocmd("PackChanged", { group = aug, callback = pack_hooks })

vim.pack.add({
	{ src = "https://github.com/catppuccin/nvim", name = "catppuccin" },
	"https://github.com/nvim-lualine/lualine.nvim",
	"https://github.com/nvim-mini/mini.nvim",
	"https://github.com/nvim-treesitter/nvim-treesitter",
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/williamboman/mason.nvim",
	"https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
	{ src = "https://github.com/saghen/blink.cmp", version = vim.version.range("1.*") },
	"https://github.com/stevearc/conform.nvim",
	"https://github.com/mfussenegger/nvim-jdtls",
	"https://github.com/rafamadriz/friendly-snippets",
	"https://github.com/mfussenegger/nvim-dap",
	"https://github.com/mfussenegger/nvim-dap-python",
	"https://github.com/julianolf/nvim-dap-lldb",
	{ src = "https://github.com/igorlfs/nvim-dap-view", version = vim.version.range("1.*") },
	"https://github.com/lewis6991/gitsigns.nvim",
})

-- Colorscheme
local flavour = "frappe"
require("catppuccin").setup({
	flavour = flavour,
	transparent_background = true,
	auto_integrations = true,
})

vim.cmd.colorscheme("catppuccin-nvim")

local pal = require("catppuccin.palettes").get_palette(flavour)
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none", update = true })
vim.api.nvim_set_hl(0, "FloatBorder", { fg = pal.surface2, bg = "none" })
vim.api.nvim_set_hl(0, "FloatTitle", { fg = pal.surface2, bg = "none" })
vim.api.nvim_set_hl(0, "MiniFilesTitleFocused", { bg = "none", update = true })
vim.api.nvim_set_hl(0, "MiniPickPrompt", { bg = "none", update = true })
vim.api.nvim_set_hl(0, "MiniPickPromptCaret", { bg = "none", update = true })
vim.api.nvim_set_hl(0, "MiniPickPromptPrefix", { bg = "none", update = true })
vim.api.nvim_set_hl(0, "MiniPickBorderText", { bg = "none", update = true })

-- Statusline
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

-- Notifications
require("mini.notify").setup({
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
})

-- File explorer
local mini_files = require("mini.files")
mini_files.setup()

local minifiles_toggle = function()
	if mini_files.close() == nil then
		mini_files.open()
	end
end
vim.keymap.set("n", "<leader>e", minifiles_toggle, { desc = "Toggle file explorer" })

-- Picker
local mini_pick = require("mini.pick")
mini_pick.setup()

vim.keymap.set("n", "<leader>ff", function()
	mini_pick.builtin.files()
end, { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", function()
	mini_pick.builtin.grep_live()
end, { desc = "Grep (live)" })
vim.keymap.set("n", "<leader>fb", function()
	mini_pick.builtin.buffers()
end, { desc = "Find buffers" })
vim.keymap.set("n", "<leader>fh", function()
	mini_pick.builtin.help()
end, { desc = "Help tags" })

-- Git signs
require("gitsigns").setup()

vim.api.nvim_create_autocmd("User", {
	group = aug,
	pattern = "GitsignsUpdate",
	callback = function()
		local ok, lualine = pcall(require, "lualine")
		if ok then
			lualine.refresh({ place = { "statusline" } })
		end
	end,
})

-- Completion
require("blink.cmp").setup({})

-- Formatting
require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "isort", "black" },
		c = { "clang_format" },
		java = { "google-java-format" },
	},
	format_on_save = {
		timeout_ms = 500,
		lsp_format = "fallback",
	},
})

-- Treesitter
require("nvim-treesitter").install({ "python", "c", "lua", "java" })
vim.api.nvim_create_autocmd("FileType", {
	group = aug,
	pattern = { "python", "c", "lua", "java" },
	callback = function()
		vim.treesitter.start()
	end,
})

-- LSP
require("mason").setup()
require("mason-tool-installer").setup({
	ensure_installed = {
		"stylua",
		"isort",
		"black",
		"google-java-format",
		"clang-format",
		"pyright",
		"clangd",
		"lua-language-server",
		"jdtls",
		"codelldb",
		"java-debug-adapter",
		"java-test",
	},
})

vim.lsp.config("*", {
	capabilities = require("blink.cmp").get_lsp_capabilities(),
})

vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
})

vim.lsp.enable({ "pyright", "clangd", "lua_ls" })

local java_debug_bundles = {
	vim.fn.glob(
		vim.fn.stdpath("data")
			.. "/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar",
		1
	),
}

local java_test_bundles =
	vim.split(vim.fn.glob(vim.fn.stdpath("data") .. "/mason/packages/java-test/extension/server/*.jar", 1), "\n")
local excluded = {
	"com.microsoft.java.test.runner-jar-with-dependencies.jar",
	"jacocoagent.jar",
}
for _, java_test_jar in ipairs(java_test_bundles) do
	local fname = vim.fn.fnamemodify(java_test_jar, ":t")
	if not vim.tbl_contains(excluded, fname) then
		table.insert(java_debug_bundles, java_test_jar)
	end
end

vim.lsp.config("jdtls", {
	cmd = function(dispatchers, config)
		local project_name = vim.fn.fnamemodify(config.root_dir or vim.fn.getcwd(), ":p:h:t")
		-- ~/.local/share/nvim/jdtls-workspace/<project-name>
		local workspace_dir = vim.fn.stdpath("data") .. "/jdtls-workspace/" .. project_name
		return vim.lsp.rpc.start({ "jdtls", "-data", workspace_dir }, dispatchers)
	end,
	init_options = {
		bundles = java_debug_bundles,
	},
})
vim.lsp.enable("jdtls")

vim.keymap.set("n", "ga", vim.lsp.buf.code_action, { desc = "Code action" })
vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
vim.keymap.set("n", "gn", vim.lsp.buf.rename, { desc = "Rename symbol" })
vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Find references" })
vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, { desc = "Go to type definition" })
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover info" })
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })

-- Debugger
require("jdtls").setup_dap({ hotcodereplace = "auto" })
require("dap-python").setup("python3")
require("dap-view").setup({})
require("dap-lldb").setup()

vim.keymap.set("n", "<leader>dc", function()
	require("dap").continue()
end, { desc = "DAP continue" })
vim.keymap.set("n", "<leader>dn", function()
	require("dap").step_over()
end, { desc = "DAP step over" })
vim.keymap.set("n", "<leader>di", function()
	require("dap").step_into()
end, { desc = "DAP step into" })
vim.keymap.set("n", "<leader>do", function()
	require("dap").step_out()
end, { desc = "DAP step out" })
vim.keymap.set("n", "<leader>db", function()
	require("dap").toggle_breakpoint()
end, { desc = "DAP breakpoint" })
vim.keymap.set("n", "<leader>dB", function()
	require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, { desc = "DAP cond breakpoint" })
vim.keymap.set("n", "<leader>dr", function()
	require("dap").repl.toggle()
end, { desc = "DAP REPL" })
vim.keymap.set("n", "<leader>dl", function()
	require("dap").run_last()
end, { desc = "DAP run last" })
vim.keymap.set("n", "<leader>dt", function()
	require("dap").terminate()
end, { desc = "DAP terminate" })
vim.keymap.set("n", "<leader>dd", "<cmd>DapViewToggle<cr>", { desc = "DAP view toggle" })
