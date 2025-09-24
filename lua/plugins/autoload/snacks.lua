--- Smorgasbord of small plugins for neovim
return {
  'folke/snacks.nvim',
  lazy = false,
  priority = 1000,
  keys = require('plugins.autoload.snacks.keys'),
  opts = {
    dashboard = require('plugins.autoload.snacks.dashboard-laptop'),
    image = { enabled = true },
    indent = { enabled = true },
    notifier = { enabled = true },
    picker = require('plugins.autoload.snacks.picker'),
    styles = { notification = { border = 'single' } },
    words = { enabled = true },

    -- Explicitly disable all the others.
    animate = { enabled = false },
    bigfile = { enabled = false },
    dim = { enabled = false },
    gitbrowse = { enabled = false },
    input = { enabled = false },
    lazygit = { enabled = false },
    profiler = { enabled = false },
    quickfile = { enabled = false },
    scope = { enabled = false },
    scratch = { enabled = false },
    scroll = { enabled = false },
    statuscolumn = { enabled = false },
    terminal = { enabled = false },
    toggle = { enabled = false },
    win = { enabled = false },
    zen = { enabled = false },
  },
}
