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
      cmd = '$XDG_CONFIG_HOME/dvim/lua/plugins/autoload/snacks/animate-logo $XDG_CONFIG_HOME/dvim/assets/logo/pretzl.cat',
      height = 20,
      indent = 41,
      padding = 0,
      width = 100,
    },

    -- PANE 1
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
    { section = 'terminal', cmd = '', gap = 10 },
    { section = 'startup', indent = 59 },

    -- PANE 2
    function()
      local in_git = Snacks.git.get_root() ~= nil
      local cmds = {
        {
          height = 19
        },
        {
          title = "Project Status",
          icon = ' ',
          cmd = "echo && git status",
          height = 5,
          indent = 1
        },
        {
          title = "Pull Requests",
          icon = ' ',
          key = 'p',
          action = function()
            vim.fn.jobstart("gh pr list --web", { detach = true })
          end,
          cmd = "echo && gh pr list -L 3 --json number,title --template '{{range .}}{{tablerow (printf \"#%v\" .number | autocolor \"green\") .title}}{{end}}'",
          height = 5,
          indent = 1
        },
        {
          title = "Notifications",
          icon = ' ',
          key = 'm',
          action = function()
            vim.ui.open("https://github.com/notifications")
          end,
          cmd = "echo && gh notify -s -a -n4 | awk '{  printf \"%s %s %-40s\\n\", $2, $3, $4; for (i = 8; i <= NF; i++) printf \"%s \", $i; printf \"\\n\" }'",
          height = 10,
          indent = 1
        },
      }
      return vim.tbl_map(function(cmd)
        return vim.tbl_extend("force", {
          pane = 2,
          section = "terminal",
          enabled = in_git,
          padding = 1,
          ttl = 5 * 60,
          indent = 1,
        }, cmd)
      end, cmds)
    end,
  },
}
