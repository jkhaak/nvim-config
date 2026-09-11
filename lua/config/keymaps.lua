-- KEYMAPS
--
-- See `:h vim.keymap.set()`, `:h mapping`, `:h keycodes`

-- faster scroll
vim.keymap.set('n', '<C-e>', '<C-e><C-e>')
vim.keymap.set('n', '<C-y>', '<C-y><C-y>')

-- Add a sane escape sequence for terminal emulation
-- vim.keymap.set('t', '<leader><Esc>', '<C-\\><C-n>', { silent = true, noremap = true })

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

