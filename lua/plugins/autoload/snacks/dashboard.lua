return {
  enabled = true,
  preset = {
    keys = {
      {
        icon = ' ',
        key = 'f',
        desc = 'Find File',
        action = ":lua Snacks.dashboard.pick('files')",
      },
      {
        icon = ' ',
        key = 'n',
        desc = 'New File',
        action = ':ene | startinsert',
      },
      {
        icon = ' ',
        key = 'g',
        desc = 'Find Text',
        action = ":lua Snacks.dashboard.pick('live_grep')",
      },
      {
        icon = ' ',
        key = 'r',
        desc = 'Recent Files',
        action = ":lua Snacks.dashboard.pick('oldfiles')",
      },
      {
        icon = ' ',
        key = 'c',
        desc = 'Config',
        action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
      },
      {
        icon = ' ',
        key = 's',
        desc = 'Restore Session',
        section = 'session',
      },
      {
        icon = '󰒲 ',
        key = 'l',
        desc = 'Lazy',
        action = ':Lazy',
        enabled = package.loaded.lazy ~= nil,
      },
      { icon = ' ', key = 'q', desc = 'Quit', action = ':qa' },
    },
  },
  sections = {
    {
      section = 'terminal',
      cmd = '([[ "$(command -v lolcat)" ]] && lolcat --seed=29 $XDG_CONFIG_HOME/dvim/assets/logo.cat) || cat $XDG_CONFIG_HOME/dvim/assets/logo.cat',
      indent = 14,
    },
    { section = 'keys', gap = 1, padding = 3 },
    { section = 'startup', gap = 1 },
  },
}
