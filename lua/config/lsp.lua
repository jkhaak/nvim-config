-- LSP configurations
local home = vim.fn.expand("$HOME")
local telescope_builtin = require('telescope.builtin')

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
    map("de", vim.lsp.buf.declaration, "Goto [De]claration")
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
