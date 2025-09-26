function big_viewport()
  return vim.o.columns >= 125 and vim.o.lines >= 45
end

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
      cmd = 'lolcat $XDG_CONFIG_HOME/dvim/assets/logo/pretzl.cat',
      height = 20, indent = 10, padding = 0,
      ttl = 0,
      enabled = big_viewport
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
        {
          cmd = string.format(
            'figlet -f rectangles "%s" | lolcat', 
            vim.fn.fnamemodify(vim.fn.getcwd(), ':t'):gsub("^.", string.upper)
          ),
          height = big_viewport() and 6 or 2,
          enabled = big_viewport
        },
        {
          icon = ' ', title = 'Git status',
          indent = 1, height = 7,
          cmd = 'echo && git changes',
          key = 's', action = ';g',
        },

        {
          icon = ' ', title = 'Pull requests',
          indent = 1, height = 3,
          cmd = 'echo && git prs -n',
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
          indent = 1, padding = 1, height = 11,
          ttl = 0,
          enabled = Snacks.git.get_root() ~= nil
        }, cmd)
      end, cmds)
    end,
  },
}
