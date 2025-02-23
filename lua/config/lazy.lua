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
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- If lazy isn't installed, clone the latest stable release.
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", lazypath })
  local clone_output = vim.fn.system({ "git", "-C", lazypath, "checkout", "tags/stable" })

  -- Just a failsafe in case the clone fails
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { clone_output,                   "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

local M = {}

function M.load(opts)
  opts = vim.tbl_deep_extend("force", {
    spec = {
      { import = 'plugins.basic' },
      { import = 'plugins.autoload' },
    },
    change_detection = { notify = false },
    checker = { enabled = false },
    debug = false,
    --defaults = { lazy = true }, -- Not yet. When I understand it better.
    install = { colorscheme = { vim.colorscheme } },

    performance = {
      cache = {
        enabled = true,
      },
      rtp = {
        disabled_plugins = {
          "gzip",
          "netrwPlugin",
          "rplugin",
          "tarPlugin",
          "tohtml",
          "tutor",
          "zipPlugin",
        },
      },
    },

    ui = {
      border = "rounded",
    },

  }, opts)

  require("lazy").setup(opts)
  vim.keymap.set('n', opts.keymap, '<cmd>Lazy<cr>')
end

return M
