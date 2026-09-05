-- Set <space> as the leader key
-- See `:h mapleader`
-- NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '

-- OPTIONS
--
-- See `:h vim.o`
-- NOTE: You can change these options as you wish!
-- For more options, you can see `:h option-list`
-- To see documentation for an option, you can use `:h 'optionname'`, for example `:h 'number'`
-- (Note the single quotes)

-- Configure backup
local backup_dir = vim.fn.expand("$HOME") .. "/.local/nvim/backup"
vim.fn.mkdir(backup_dir, "p")
vim.o.backupdir = backup_dir
vim.o.backup = true

vim.o.number = true -- Show line numbers in a column.

-- Show line numbers relative to where the cursor is.
-- Affects the 'number' option above, see `:h number_relativenumber`.
vim.o.relativenumber = true

-- Sync clipboard between OS and Neovim. Schedule the setting after `UIEnter` because it can
-- increase startup-time. Remove this option if you want your OS clipboard to remain independent.
-- See `:h 'clipboard'`
vim.api.nvim_create_autocmd('UIEnter', {
  callback = function()
    vim.o.clipboard = 'unnamedplus'
  end,
})

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.cursorline = true -- Highlight the line where the cursor is on.
vim.o.scrolloff = 7  -- Keep this many screen lines above/below the cursor.
vim.o.list = true -- Show <tab> and trailing spaces.

-- If performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s). See `:h 'confirm'`
vim.o.confirm = true

-- set default shell
vim.o.shell = 'fish'

-- set indentation to 4 spaces by default
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.softtabstop = 4

-- KEYMAPS
--
-- See `:h vim.keymap.set()`, `:h mapping`, `:h keycodes`

-- faster scroll
vim.keymap.set('n', '<C-e>', '<C-e><C-e>')
vim.keymap.set('n', '<C-y>', '<C-y><C-y>')

-- Add a sane escape sequence for terminal emulation
vim.keymap.set('t', '<leader><Esc>', '<C-\\><C-n>', { silent = true, noremap = true })

-- Map <A-j>, <A-k>, <A-h>, <A-l> to navigate between windows in any modes
vim.keymap.set('t', '<C-h>', '<C-\\><C-n><C-w>h')
vim.keymap.set('t', '<C-j>', '<C-\\><C-n><C-w>j')
vim.keymap.set('t', '<C-k>', '<C-\\><C-n><C-w>k')
vim.keymap.set('t', '<C-l>', '<C-\\><C-n><C-w>l')
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')

-- remap C-] and C-[
vim.keymap.set({ 'n' }, "<C-->", '<C-[>', {
  desc = "Jump previous definition (tag jump)",
  noremap = true,
  silent = true,
})
vim.keymap.set({ 'n' }, "<C-'>", '<C-]>', {
  desc = "Jump to definition (tag jump)",
  noremap = true,
  silent = true,
})

-- remap [c and ]c 
vim.keymap.set({ 'n' }, '-c', '[c', { desc = "Previous diff change" })
vim.keymap.set({ 'n' }, "'c", ']c', { desc = "Next diff change" })

-- remap H and L to start of a line and end of a line
vim.keymap.set({ 'n' }, 'H', '^', { desc = "Jump to start of a line" })
vim.keymap.set({ 'n' }, 'L', '$', { desc = "Jump to end of a line" })

-- show diagnostics
vim.keymap.set({ 'n' }, 'gD', vim.diagnostic.open_float, { desc = "Open diagnostics float" })

-- AUTOCOMMANDS (EVENT HANDLERS)
--
-- See `:h lua-guide-autocommands`, `:h autocmd`, `:h nvim_create_autocmd()`

-- Highlight when yanking (copying) text.
-- Try it with `yap` in normal mode. See `:h vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  callback = function()
    vim.hl.on_yank()
  end,
})

vim.api.nvim_create_autocmd('DirChanged', {
  pattern = '*',
  callback = function(args)
    local cwd = vim.fn.getcwd()

    if cwd:match("zig-proj") then
      vim.o.makeprg = "zig build"
    end
  end,
})

-- FILETYPE CONFIGS
vim.api.nvim_create_autocmd("FileType", {
  pattern = "lua",
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
    vim.opt_local.expandtab = true
  end,
})

-- USER COMMANDS: DEFINE CUSTOM COMMANDS
--
-- See `:h nvim_create_user_command()` and `:h user-commands`

-- Create a command `:GitBlameLine` that print the git blame for the current line
vim.api.nvim_create_user_command('GitBlameLine', function()
  local line_number = vim.fn.line('.') -- Get the current line number. See `:h line()`
  local filename = vim.api.nvim_buf_get_name(0)
  print(vim.system({ 'git', 'blame', '-L', line_number .. ',+1', filename }):wait().stdout)
end, { desc = 'Print the git blame for the current line' })

-- PLUGINS
--
-- See `:h :packadd`, `:h vim.pack`

-- Add the "nohlsearch" package to automatically disable search highlighting after
-- 'updatetime' and when going to insert mode.
vim.cmd('packadd! nohlsearch')

-- Install third-party plugins via "vim.pack.add()".
vim.pack.add({
  -- fix nested nvim instances. must be first.
  'https://github.com/willothy/flatten.nvim',

  -- Quickstart configs for LSP
  'https://github.com/neovim/nvim-lspconfig',
  -- Fuzzy picker
  -- 'https://github.com/ibhagwan/fzf-lua',
  -- mini.vim stuff
  'https://github.com/nvim-mini/mini.completion',
  'https://github.com/nvim-mini/mini.surround',
  -- Enhanced quickfix/loclist
  'https://github.com/stevearc/quicker.nvim',
  -- Git integration
  'https://github.com/lewis6991/gitsigns.nvim',
  -- Fuzzy picker
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/nvim-telescope/telescope.nvim',

  -- harpoon2
  {
    src = 'https://github.com/ThePrimeagen/harpoon',
    version = 'harpoon2'
  },

  -- Languages

  -- go
  -- better syntax highlighting for gotmpl
  'https://github.com/ngynkvn/gotmpl.nvim',

  -- zig zls
  'https://codeberg.org/ziglang/zig.vim',
})
-- To remove old packages `:lua vim.pack.update()`

-- require('fzf-lua').setup { fzf_colors = true }
require('mini.completion').setup {}
require('mini.surround').setup {}
require('quicker').setup {}
require('gitsigns').setup {}

local telescope_builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', telescope_builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', telescope_builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', telescope_builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fn', telescope_builtin.help_tags, { desc = 'Telescope help tags' })

local harpoon = require('harpoon')
harpoon:setup()

vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end)
vim.keymap.set("n", "<leader>hm", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<C-t>", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<C-n>", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<C-s>", function() harpoon:list():select(4) end)

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)

local home = vim.fn.expand("$HOME")

-- LSP configurations

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    local map = function(keys, func, desc)
      vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
    end

    map("gd", telescope_builtin.lsp_definitions, "[G]oto [D]efinition")
    map("gr", telescope_builtin.lsp_references, "[G]oto [R]eferences")
    map("gI", telescope_builtin.lsp_implementations, "[G]oto [I]mplementation")
    map("K", vim.lsp.buf.hover, "Hover Documentation")
    map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
    map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
    map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
  end,
})

-- Go
vim.lsp.config('gopls', {
  settings = {
    gopls = {
      staticcheck = true,
      gofumpt = true,
    },
  },
})
vim.lsp.enable('gopls')

vim.filetype.add({
  extension = { gotmpl = 'gotmpl' },
  pattern = {
    ["%.go%.tmpl$"] = "gotmpl",
  },
})

-- Zig

-- Configure zls
-- don't show parse errors in a separate window
vim.g.zig_fmt_parse_errors = 0
-- disable format-on-save from `ziglang/zig.vim`
vim.g.zig_fmt_autosave = 0
-- enable  format-on-save from vim.lsp + ZLS

-- Formatting with ZLS matches `zig fmt`.
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = { "*.zig", "*.zon" },
  callback = function(ev)
    vim.lsp.buf.format()
  end
})

vim.lsp.config('zls', {
  -- Set to 'zls' if `zls` is in your PATH

  cmd = { home .. '/.local/bin/zls' },
  filetypes = { 'zig' },
  root_markers = { 'build.zig' },
  -- There are two ways to set config options:
  --   - edit your `zls.json` that applies to any editor that uses ZLS
  --   - set in-editor config options with the `settings` field below.
  --
  -- Further information on how to configure ZLS:
  -- https://zigtools.org/zls/configure/
  settings = {
    zls = {
      -- Whether to enable build-on-save diagnostics
      --
      -- Further information about build-on save:
      -- https://zigtools.org/zls/guides/build-on-save/
      -- enable_build_on_save = true,

      -- omit the following line if `zig` is in your PATH
      zig_exe_path = home .. '/.local/bin/zig'
    }
  },
})
vim.lsp.enable('zls')
