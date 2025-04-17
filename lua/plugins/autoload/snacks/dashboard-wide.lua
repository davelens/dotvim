return {
  enabled = true,
  width = 60,
  -- stylua: ignore
  sections = {
    {
      pane = 1,
      section = 'terminal',
      -- cmd = '([[ "$(command -v lolcat)" ]] && lolcat --seed=40 --spread=20 $XDG_CONFIG_HOME/dvim/assets/logo/pretzl-half-1.cat) || cat $XDG_CONFIG_HOME/dvim/assets/logo/pretzl-half-1.cat',
      cmd = '$XDG_CONFIG_HOME/dvim/lua/plugins/autoload/snacks/animate-logo $XDG_CONFIG_HOME/dvim/assets/logo/pretzl-half-1.cat',
      height = 20,
      indent = 41,
      padding = 0,
    },
    {
      pane = 2,
      section = 'terminal',
      -- cmd = '([[ "$(command -v lolcat)" ]] && lolcat --seed=40 --spread=20 $XDG_CONFIG_HOME/dvim/assets/logo/pretzl-half-2.cat) || cat $XDG_CONFIG_HOME/dvim/assets/logo/pretzl-half-2.cat',
      cmd = '$XDG_CONFIG_HOME/dvim/lua/plugins/autoload/snacks/animate-logo $XDG_CONFIG_HOME/dvim/assets/logo/pretzl-half-2.cat',
      height = 20,
      indent = -4,
      padding = 0,
    },
    {
      pane = 1,
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
      pane = 1,
      title = "Configuration\n ",
      indent = 1,
      padding = 2,
      gap = 1,
      { icon = ' ', key = 'c', desc = 'Neovim',        action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})", },
      { icon = '󰒲 ', key = 'l', desc = 'Lazy',          action = ':Lazy', enabled = package.loaded.lazy ~= nil },
      { icon = '⛨ ', key = 'h', desc = 'Check health',  action = ':checkhealth' },
    },
    function()
      local in_git = Snacks.git.get_root() ~= nil
      local cmds = {
        {
          title = "Git Status",
          cmd = "git status",
          height = 7,
        },
        {
          title = "Github PRs",
          cmd = "gh pr list -L 3 --json number,title --template '{{range .}}{{tablerow (printf \"#%v\" .number | autocolor \"green\") .title}}{{end}}'",
          height = 7,
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
    { pane = 2, section = 'startup', align = 'left', gap = 1 },
  },
}
