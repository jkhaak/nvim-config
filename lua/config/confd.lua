local M = {}

function M.load()
  local conf_dir = vim.fn.stdpath('config') .. '/conf.d'

  if vim.fn.isdirectory(conf_dir) == 0 then
    return
  end

  local files = vim.fn.glob(conf_dir .. '/*.lua', true)
  if #files == 0 then
    return
  end

  table.sort(files)

  for _, f in ipairs(files) do
    local ok, err = pcall(dofile, f)
    if not ok then
      vim.schedule(function()
        vim.notify(('conf.d: error in %s\n%s'):format(f, err), vim.log.levels.ERROR)
      end)
    end
  end
end

return M
