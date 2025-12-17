-- This file is intended to be the entry point for configuring lazy.nvim.
-- It does the heavy lifting so our init.lua is more readable.
--
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

-- Make sure lazy.nvim is installed
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

-- If lazy isn't installed, clone the latest stable release.
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    lazypath,
  })
  local clone_output =
    vim.fn.system({ 'git', '-C', lazypath, 'checkout', 'tags/stable' })

  -- Just a failsafe in case the clone fails
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
      { clone_output, 'WarningMsg' },
      { '\nPress any key to exit...' },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

local M = {}

function M.load(opts)
  -- Detect first run (no plugins installed yet)
  local lazy_path = vim.fn.stdpath('data') .. '/lazy'
  local first_run = vim.fn.isdirectory(lazy_path .. '/nvim-treesitter') == 0

  opts = vim.tbl_deep_extend('force', {
    spec = {
      { import = 'plugins.basic' },
      { import = 'plugins.autoload' },
    },
    change_detection = { notify = false },
    checker = { enabled = false },
    debug = false,
    -- On first run, skip auto-install to avoid sourcing errors.
    -- User must run :Lazy sync manually, then restart.
    install = {
      missing = not first_run,
      colorscheme = { vim.colorscheme },
    },

    performance = {
      cache = {
        enabled = true,
      },
      rtp = {
        disabled_plugins = {
          'gzip',
          'netrwPlugin',
          'rplugin',
          'tarPlugin',
          'tohtml',
          'tutor',
          'zipPlugin',
        },
      },
    },

    ui = {
      border = 'rounded',
    },
  }, opts)

  require('lazy').setup(opts)

  -- On first run, prompt user to sync and restart
  if first_run then
    vim.defer_fn(function()
      vim.notify(
        'First run detected. Run :Lazy sync then restart Neovim.',
        vim.log.levels.WARN
      )
      vim.cmd('Lazy')
    end, 100)
  end

  vim.keymap.set(
    'n',
    opts.keymap,
    '<cmd>Lazy<cr>',
    { desc = 'Plugins (lazy.nvim)' }
  )
end

return M
