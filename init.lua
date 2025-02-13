-- Setting package.path ensures that require() knows where to look for files.
local config_path = vim.fn.stdpath("config")
package.path = config_path .. "/lua/?.lua;" .. config_path .. "/lua/?/init.lua;" .. package.path

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
require('homebrew.functions')
require('homebrew.options')
require('homebrew.clipboard')

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " " -- using space as leader key
vim.g.maplocalleader = "," -- using comma as local leader
vim.g.loaded_perl_provider = 0 -- disable perl provider

-- So lazy.nvim is configured to autoload these files:
-- * lua/plugins/basic.lua
-- * lua/plugins/autoload/*.lua
--
-- plugins/basic.lua loads all plugins that don't require additional 
-- configuration.
--
-- plugins/autoload/*.lua are files intended to contain a single plugin
-- per file, with additional configuration.
--
-- If the configuration is extensive, additional settings should be put in 
-- plugins/config/*.lua and loaded from a plugins/autoload/*.lua file.
require("lazy").setup({
    { import = 'plugins.basic' }, 
    { import = 'plugins.autoload' }, 
  }, {
    change_detection = { notify = false },
    -- Configure any other settings here. See the documentation for more details.
    -- colorscheme that will be used when installing plugins.
    install = { colorscheme = { vim.colorscheme } },
    -- automatically check for plugin updates
    checker = { enabled = true, notify = false },
    ui = { border = "rounded" }
  }
)

-- Some easier access to the Lazy dashboard.
vim.keymap.set('n', '<leader>L', ':Lazy<cr>', {})

-- Executed here so our maps always override any plugin maps.
require('homebrew.autocommands')
require('homebrew.maps')

-- The value is set in lua/homebrew/options.lua.
-- Doing this here because the catppuccin plugin does not load automatically.
vim.cmd("colorscheme " .. vim.colorscheme)
