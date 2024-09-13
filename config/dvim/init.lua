local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Functions and options are set here. I want plugins to hijack these, as
-- any installed overrides would be intentional.
require('neovim/functions')
require('neovim/options')

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " " -- using space as leader key
vim.g.maplocalleader = "," -- using comma as local leader

-- Bootstrap lazy.nvim to load in lua/plugins/*.lua, and lua/plugins.lua.
require("lazy").setup('plugins', {
  change_detection = { notify = false },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { vim.colorscheme } },
  -- automatically check for plugin updates
  checker = { enabled = true },
  ui = { border = "rounded" }
})

-- Some easier access to the Lazy dashboard.
vim.keymap.set('n', '<leader>L', ':Lazy<cr>', {})

-- Executed here so our maps always override any plugin maps.
require('neovim/autocommands')
require('neovim/maps')
