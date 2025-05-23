return {
  enabled = true,
  width = 51,
  -- stylua: ignore
  sections = {
    {
      section = 'terminal',
      cmd = 'lolcat $XDG_CONFIG_HOME/dvim/assets/logo/pretzl.cat',
      height = 20,
      indent = 6,
      padding = 0,
      gap = 1,
    },
    {
      title = "Actions\n ",
      indent = 1,
      gap = 1,
      padding = 1,
      { icon = ' ', key = 'n', desc = 'New File',      action = ':ene | startinsert' },
      { icon = ' ', key = 'r', desc = 'Recent Files',  action = ":lua Snacks.dashboard.pick('oldfiles')" },
      { icon = ' ', key = 'f', desc = 'Find File',     action = ":lua Snacks.dashboard.pick('files')" },
      { icon = ' ', key = 'g', desc = 'Find Text',     action = ":lua Snacks.dashboard.pick('live_grep')", },
      { icon = ' ', key = 'q', desc = 'Quit',          action = ':qa' },
    },
    {
      title = "Configuration\n ",
      indent = 1,
      padding = 2,
      gap = 1,
      { icon = ' ', key = 'c', desc = 'Neovim',        action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})", },
      { icon = '󰒲 ', key = 'l', desc = 'Lazy',          action = ':Lazy', enabled = package.loaded.lazy ~= nil },
      { icon = '⛨ ', key = 'h', desc = 'Check health',  action = ':checkhealth' },
    },
    { section = 'startup', gap = 1 },
  },
}
