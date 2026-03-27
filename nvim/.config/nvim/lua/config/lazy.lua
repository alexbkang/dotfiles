local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Compatibility: `vim.tbl_flatten` is deprecated in newer Neovim.
-- Some plugins (e.g. lualine.nvim) still call it.
do
	local v = vim.version and vim.version() or nil
	if v and v.major == 0 and v.minor >= 11 then
		vim.tbl_flatten = function(t)
			local out = {}
			local function flatten(x)
				if type(x) == "table" then
					for _, v2 in ipairs(x) do
						flatten(v2)
					end
				else
					out[#out + 1] = x
				end
			end
			flatten(t)
			return out
		end
	end
end

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
vim.opt.cmdheight = 0
vim.opt.winborder = "single"
vim.opt.winblend = 0
vim.opt.pumblend = 0

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.diagnostic.config({
	signs = false,
	virtual_text = true,
})

require("lazy").setup({
	spec = {
		{ import = "plugins" },
	},
	ui = {
		border = "single",
		size = {
			width = 1,
			height = 1,
		},
	},
	checker = { enabled = true },
})
