-- PLUGINS
--
-- See `:h :packadd`, `:h vim.pack`

-- Add the "nohlsearch" package to automatically disable search highlighting after
-- 'updatetime' and when going to insert mode.
vim.cmd('packadd! nohlsearch')

local sources = {
  -- fix nested nvim instances. must be first.
  'https://github.com/willothy/flatten.nvim',

  -- Quickstart configs for LSP
  'https://github.com/neovim/nvim-lspconfig',

  -- Also we need treesitter
  'https://github.com/nvim-treesitter/nvim-treesitter',

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
}

local ok_local, local_cfg = pcall(require, 'config.local')
if ok_local and local_cfg.plugin_sources then
  vim.list_extend(sources, local_cfg.plugin_sources)
end

-- Install third-party plugins via "vim.pack.add()".
vim.pack.add(sources)
-- To remove old packages `:lua vim.pack.update()`

require('mini.completion').setup {}
require('mini.surround').setup {}
require('quicker').setup {}
require('gitsigns').setup {}

