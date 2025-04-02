-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = ' ' -- using space as leader key
vim.g.maplocalleader = ',' -- using comma as local leader
-- :checkhealth won't whine about these when disabled.
vim.g.loaded_perl_provider = 0 -- disable perl provider
vim.g.loaded_node_provider = 0 -- disable node provider
vim.g.loaded_ruby_provider = 0 -- disable ruby provider
vim.g.loaded_python_provider = 0 -- disable python provider

-- Clipboard settings for WSL. I use `cb` on macos as well, so the conditional
-- might not be necessary. I'll find out later.
if vim.fn.has('wsl') == 1 then
  vim.g.clipboard = {
    name = 'WslClipboard',
    copy = {
      ['+'] = 'clip.exe',
      ['*'] = 'clip.exe',
    },
    paste = {
      ['+'] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
      ['*'] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
    },
    cache_enabled = 0,
  }
end

vim.diagnostic.config({
  virtual_lines = true,
  -- Only show virtual line diagnostics for the current cursor line
  -- current_line = true,
})

-- Inject Blink's capabilities into the LSP config for all filetypes.
-- The schedule just makes sure it's delayed until our plugins are loaded.
vim.schedule(function()
  if vim.fn.has('nvim-0.11') == 1 and vim.lsp.config then
    vim.lsp.config(
      '*',
      { capabilities = require('blink.cmp').get_lsp_capabilities() }
    )
  end
end)

vim.lsp.set_log_level('debug')
vim.lsp.enable({ 'ruby_lsp', 'lua_ls', 'elixir_ls' })
