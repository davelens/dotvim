-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = ' '            -- using space as leader key
vim.g.maplocalleader = ','       -- using comma as local leader
-- :checkhealth won't whine about these when disabled.
vim.g.loaded_perl_provider = 0   -- disable perl provider
vim.g.loaded_node_provider = 0   -- disable node provider
vim.g.loaded_ruby_provider = 0   -- disable ruby provider
vim.g.loaded_python_provider = 0 -- disable python provider

-- Clipboard settings for WSL. I use `cb` on macos as well, so the conditional
-- might not be necessary. I'll find out later.
if vim.fn.has('wsl') == 1 then
  vim.g.clipboard = {
    cache_enabled = 0,
    name = 'WslClipboard',
    copy = {
      ['+'] = 'cb copy',
      ['*'] = 'cb copy',
    },
    paste = {
      ['+'] = 'cb paste',
      ['*'] = 'cb paste',
    },
  }
end
