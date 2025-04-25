return {
  enabled = true,
  width = 60,
  formats = {
    key = function(item)
      return {
        { '[', hl = 'special' },
        { item.key, hl = 'key' },
        { ']', hl = 'special' },
      }
    end,
  },
  -- stylua: ignore
  sections = {
    {
      section = 'terminal',
      cmd = 'utility misc rgb $XDG_CONFIG_HOME/dvim/assets/logo/pretzl.cat',
      height = 20, indent = 10, padding = 0,
    },

    -- PANE 1
    {
      title = "Actions\n ",
      gap = 1, indent = 1, padding = 2,
      { icon = ' ', key = 'n', desc = 'New File',      action = ':ene | startinsert' },
      { icon = ' ', key = 'r', desc = 'Recent Files',  action = ":lua Snacks.dashboard.pick('oldfiles')" },
      { icon = ' ', key = 'f', desc = 'Find File',     action = ":lua Snacks.dashboard.pick('files')" },
      { icon = ' ', key = 'g', desc = 'Find Text',     action = ":lua Snacks.dashboard.pick('live_grep')", },
      { icon = ' ', key = 'q', desc = 'Quit',          action = ':qa' },
    },

    {
      title = "Configuration\n ",
      gap = 1, indent = 1, padding = 2,
      { icon = ' ', key = 'c', desc = 'Neovim',        action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})", },
      { icon = '󰒲 ', key = 'l', desc = 'Lazy',          action = ':Lazy', enabled = package.loaded.lazy ~= nil },
      -- { icon = '⛨ ', key = 'h', desc = 'Check health',  action = ':checkhealth' },
    },

    { section = 'startup' },

    -- PANE 2
    function()
      local cmds = {
        { cmd = '', height = 5 },
        {
          icon = ' ', title = 'Git status',
          indent = 1, height = 7,
          cmd = 'echo && git changes',
          key = 's', action = '<leader>g',
        },

        {
          icon = ' ', title = 'Pull requests',
          indent = 1, height = 10,
          cmd = 'echo && git prs',
          key = 'p', action = function()
            vim.fn.jobstart("gh pr list --web", { detach = true })
          end,
        },

        {
          icon = ' ', title = "Notifications",
          indent = 1, height = 12,
          cmd = 'echo && git notifications',
          key = 'm', action = function()
            vim.ui.open(
              string.format(
                'https://github.com/notifications?query=repo:%s',
                vim.fn.system('git repo')
              )
            )
          end,
        },
      }

      return vim.tbl_map(function(cmd)
        return vim.tbl_extend('force', {
          pane = 2,
          section = 'terminal',
          indent = 1, padding = 1,
          ttl = 5 * 60,
          enabled = function()
            return Snacks.git.get_root() ~= nil and vim.o.columns >= 120
          end,
        }, cmd)
      end, cmds)
    end,
  },
}
