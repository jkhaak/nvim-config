-- TREE SITTER
local treesitter = require('nvim-treesitter')

-- Setup treesitter
local ts_parsers = {
  'golang',
  'javascript',
  'typescript',
  'markdown',
  'elixir',
  'zig',
}

local non_filetypes = {
  'markdown_inline',
  'regex',
  'jsdoc',
  'luadoc',
  'query'
}

local filetypes = vim.tbl_filter(function(p)
  return not vim.tbl_contains(non_filetypes, p)
end, ts_parsers)

treesitter.install(ts_parsers)

-- In container builds, wait for async parser installation to finish so the
-- `nvim -c "qa"` in the Dockerfile doesn't kill it mid-build.
if vim.env.NVIM_PACK_SYNC then
  local ok = vim.wait(600000, function()
    for _, p in ipairs(ts_parsers) do
      if #vim.api.nvim_get_runtime_file(('parser/%s.so'):format(p), false) == 0 then
        return false
      end
    end
    return true
  end, 500)
  if not ok then
    error('timed out waiting for tree-sitter parsers to build')
  end
end

vim.api.nvim_create_autocmd('FileType', {
  pattern = filetypes,
  group = vim.api.nvim_create_augroup('treesitter-enable', { clear = true}),
  callback = function(args) vim.treesitter.start(args.buf) end,
})

