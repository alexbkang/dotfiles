-- vim options
vim.o.guicursor = "n-v-c-i:block"
vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorline = true
vim.o.wrap = false
vim.o.scrolloff = 10
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.autoindent = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.fillchars = "eob: "
vim.o.clipboard = "unnamedplus"
vim.o.undofile = true
vim.o.undolevels = 10000
vim.o.shortmess = vim.o.shortmess .. "I"

vim.g.mapleader = " "

-- diagnostics
vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "󰅚 ",
      [vim.diagnostic.severity.WARN] = "󰀪 ",
      [vim.diagnostic.severity.INFO] = "󰋽 ",
      [vim.diagnostic.severity.HINT] = "󰌶 ",
    },
  },
  virtual_text = true,
})

-- colorscheme
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
  dimmed1 = "#777b74",
  dimmed2 = "#777b74",
  dimmed3 = "#777b74",
  dimmed4 = "#777b74",
  dimmed5 = "#777b74",
}

vim.pack.add({ "https://github.com/loctvl842/monokai-pro.nvim" })
require("monokai-pro").setup({
  transparent_background = true,
  disabled_plugins = { "saghen/blink.cmp" },
  override_palette = function()
    return palette
  end,
})
vim.cmd.colorscheme("monokai-pro")

vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "FloatBorder", { fg = palette.dimmed3, bg = "none" })
vim.api.nvim_set_hl(0, "Pmenu", { fg = palette.text, bg = "none" })
vim.api.nvim_set_hl(0, "BlinkCmpMenuBorder", { fg = palette.dimmed3, bg = "none" })
vim.api.nvim_set_hl(0, "PmenuSel", { link = "CursorLine" })
vim.api.nvim_set_hl(0, "WinSeparator", { fg = palette.text })
vim.o.winborder = "single"
vim.o.winblend = 0
vim.o.pumblend = 0

-- dependencies
vim.pack.add({ "https://github.com/mason-org/mason.nvim" })  -- LSP
require("mason").setup()                                     -- LSP: setup is required
vim.pack.add({ "https://github.com/neovim/nvim-lspconfig" }) -- LSP
vim.lsp.config("lua_ls", {                                   -- LSP: disable vim global warning
  settings = {
    Lua = {
      diagnostics = { globals = { "vim" } },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
    },
  },
})
vim.pack.add({ "https://github.com/rafamadriz/friendly-snippets" })    -- autocomplete
vim.pack.add({ "https://github.com/nvim-mini/mini.nvim" })             -- mini plugins & codediff
vim.pack.add({ "https://github.com/nvim-lua/plenary.nvim" })           -- mini plugins & codediff & neotest
vim.pack.add({ "https://github.com/esmuellert/codediff.nvim" })        -- mini plugins & codediff
vim.pack.add({ "https://github.com/antoinemadec/FixCursorHold.nvim" }) -- neotest
vim.pack.add({ "https://github.com/nvim-neotest/nvim-nio" })           -- neotest
vim.pack.add({ "https://github.com/ldelossa/litee.nvim" })             -- gh
vim.pack.add({ "https://github.com/MunifTanjim/nui.nvim" })            -- noice

-- LSP
vim.pack.add({ "https://github.com/mason-org/mason-lspconfig.nvim" })
require("mason-lspconfig").setup({
  ensure_installed = { "jdtls", "gopls", "pyright", "ts_ls", "lua_ls" },
  automatic_enable = true,
})
vim.cmd([[
  unmap gra
  unmap gri
  unmap grn
  unmap grr
  unmap grt
]])
vim.keymap.set("n", "ga", vim.lsp.buf.code_action, { desc = "Code action" })
vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
vim.keymap.set("n", "gn", vim.lsp.buf.rename, { desc = "Rename symbol" })
vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Find references" })
vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, { desc = "Go to type definition" })
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover info" })
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Find references" })

-- treesitter
vim.api.nvim_create_autocmd("PackChanged",
  {                                                                            -- automatically run a build after plugin installs or updates
    group = vim.api.nvim_create_augroup("treesitter_build", { clear = true }), -- create arbitrary group in case of multiple source
    callback = function(ev)
      local name, kind = ev.data.spec.name, ev.data.kind
      if name == "nvim-treesitter" and (kind == "install" or kind == "update") then
        vim.cmd("TSUpdate")
      end
    end,
  })
vim.pack.add({ "https://github.com/nvim-treesitter/nvim-treesitter" })
require("nvim-treesitter.install").install({ -- install languages
  "java",
  "go",
  "python",
  "javascript",
  "typescript",
  "lua",
})
vim.api.nvim_create_autocmd("FileType", { -- treesitter highlighting for these languages
  pattern = {
    "java",
    "go",
    "python",
    "javascript",
    "typescript",
    "lua",
  },
  callback = function()
    vim.treesitter.start()
  end,
})

-- autocomplete
vim.pack.add({ { src = "https://github.com/saghen/blink.cmp", version = vim.version.range(">=1.0 <2.0") } })
require("blink.cmp").setup({})

-- formatter
vim.pack.add({ "https://github.com/stevearc/conform.nvim" })
require("conform").setup({
  formatters_by_ft = {},
  format_on_save = {
    timeout_ms = 500,
    lsp_format = "fallback",
  },
})

-- neogit
vim.pack.add({ "https://github.com/NeogitOrg/neogit" })
vim.keymap.set("n", "<leader>g", "<cmd>Neogit<cr>", { desc = "Neogit UI" })

-- github
vim.pack.add({ "https://github.com/ldelossa/gh.nvim" })

-- neotest
vim.pack.add({ "https://github.com/nvim-neotest/neotest" })

-- undodiff
vim.pack.add({ "https://github.com/alexbkang/undodiff" })
require("undodiff").setup()
vim.keymap.set("n", "<leader>t", "<cmd>UndoDiff<cr>", { desc = "UndoDiff UI" })

-- cmdline
vim.o.cmdheight = 0
vim.pack.add({ "https://github.com/folke/noice.nvim" })
require("noice").setup({
  cmdline = {
    format = {
      cmdline = { title = "" },
      search_down = { title = "" },
      search_up = { title = "" },
      filter = { title = "" },
      lua = { title = "" },
      help = { title = "" },
      input = { title = "" },
    },
  },
  views = {
    cmdline_popup = {
      border = {
        style = "single",
      },
      position = {
        row = 5,
      },
      size = {
        width = 40,
      },
    },
  },
  messages = {
    enabled = false,
  },
  popupmenu = {
    enabled = false,
  },
  lsp = {
    progress = { enabled = false },
    hover = { enabled = false },
    signature = { enabled = false },
    message = { enabled = false },
  },
})

-- mini plugins
-- helpers
require("mini.icons").setup()
require("mini.icons").mock_nvim_web_devicons()
require("mini.ai").setup()
require("mini.surround").setup()
require("mini.pairs").setup()
require("mini.diff").setup({
  view = {
    style = "sign",
  },
})
vim.api.nvim_set_hl(0, "MiniDiffSignAdd", { fg = palette.accent4 })
vim.api.nvim_set_hl(0, "MiniDiffSignChange", { fg = palette.accent3 })
vim.api.nvim_set_hl(0, "MiniDiffSignDelete", { fg = palette.accent1 })
require("mini.indentscope").setup({
  draw = { animation = require("mini.indentscope").gen_animation.none() },
})
require("mini.move").setup({})
require("mini.clue").setup()
-- fuzzy finder
require("mini.pick").setup()
vim.keymap.set("n", "<leader>ff", MiniPick.builtin.files, { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", MiniPick.builtin.grep_live, { desc = "Grep live" })
vim.keymap.set("n", "<leader>fb", MiniPick.builtin.buffers, { desc = "Find buffers" })
vim.keymap.set("n", "<leader>fh", MiniPick.builtin.help, { desc = "Find help" })
vim.keymap.set("n", "<leader>fr", MiniPick.builtin.resume, { desc = "Resume picker" })
-- file explorer
require("mini.files").setup({
  mappings = {
    go_in_plus = "<CR>",
    go_out = "H",
    go_out_plus = "h",
  },
  windows = {
    preview = true,
    width_focus = 30,
    width_preview = 30,
  },
})
vim.keymap.set("n", "<leader>e", function()
  local path = vim.api.nvim_buf_get_name(0)
  require("mini.files").open(path ~= "" and path or vim.uv.cwd())
end, { desc = "Open mini.files" })
-- statusline
require("mini.statusline").setup({
  content = {
    active = function()
      local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
      local diff = MiniStatusline.section_diff({ trunc_width = 75 })
      local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75 })
      local lsp = MiniStatusline.section_lsp({ trunc_width = 75 })
      local filename = MiniStatusline.section_filename({ trunc_width = 75 })
      local fileinfo = MiniStatusline.section_fileinfo({ trunc_width = 999 })
      local location = MiniStatusline.section_location({ trunc_width = 999 })
      local search = MiniStatusline.section_searchcount({ trunc_width = 75 })

      return MiniStatusline.combine_groups({
        { hl = mode_hl,                  strings = { mode } },
        { hl = "MiniStatuslineFilename", strings = { filename } },
        "%=",
        { hl = "MiniStatuslineDevinfo",  strings = { search, diff, diagnostics, lsp } },
        { hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
        { hl = mode_hl,                  strings = { location } },
      })
    end,
  },
})
