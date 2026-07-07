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

-- This removes some excessive clutter; I'm fine with virtual lines on actual
-- errors. Warnings are fine as-is with virtual text.
vim.diagnostic.config({
  virtual_text = {
    severity = { max = vim.diagnostic.severity.WARN },
  },
  virtual_lines = {
    severity = { min = vim.diagnostic.severity.ERROR },
  },
})

-- Blink's LSP capabilities are injected from blink.cmp's own `config` (see
-- plugins/autoload/blink.lua). blink loads at startup, which runs before any
-- LSP server attaches to the first buffer, so capabilities are always present.
vim.lsp.enable({ 'ruby', 'lua', 'elixir', 'bash', 'rust' })
