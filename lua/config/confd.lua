local M = {}

function M.load()
  local conf_dir = vim.fn.stdpath('config') .. '/conf.d'

  if vim.fn.isdirectory(conf_dir) == 0 then
    return
  end

  local files = vim.fs.find(function(name, path)
    return name:match('%.lua$') ~= nil
  end, { path = conf_dir, type = 'file' })

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
