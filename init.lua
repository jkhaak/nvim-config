-- Set <space> as the leader key
-- See `:h mapleader`
-- NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '

local configs = {
  'options',
  'keymaps',
  'autocmds',
  'usercmds',
  'plugins',
  'treesitter',
  'telescope-harpoon',
  'lsp',
}

for _, mod in ipairs(configs) do
  require('config.' .. mod)
end

-- for local adjustments
pcall(require, 'config.local')

