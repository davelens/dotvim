math.randomseed(os.time())
local lolseed = math.random(1, 1000000)
local base_project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':t')

local function long_project_name()
  return #base_project_name >= 15
end

local function is_git_project()
  return vim.fn.isdirectory(vim.fn.getcwd() .. '/.git') == 1
end

local function project_name()
  if long_project_name() then
    local cwd = vim.fn.getcwd()
    local parts = vim.split(cwd, '/')
    return table.concat({ parts[#parts - 1] or '', parts[#parts] }, '/')
  else
    return base_project_name
  end
end

local function wide_viewport()
  return vim.o.columns >= 125
end

local function tall_viewport()
  return vim.o.lines >= 45
end

local function big_viewport()
  return wide_viewport() and tall_viewport()
end

local function project_header()
  local command = 'figlet -f rectangles -w 60 "%s"'

  if long_project_name() then
    command = 'echo && echo "' .. project_name() .. '"'
  end

  return string.format(
    command .. ' | lolcat --seed=' .. lolseed,
    project_name():gsub('^.', string.upper)
  )
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
      cmd = 'lolcat --seed=' .. lolseed .. ' $XDG_CONFIG_HOME/dvim/assets/logo/pretzl.cat',
      height = 19, indent = 10, padding = 0,
      ttl = 0,
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
      { icon = '⛨ ', key = 'h', desc = 'Check health',  action = ':checkhealth' },
    },

    { section = 'startup' },

    -- PANE 2
    function()
      local cmds = {
        {
          icon = ' ', title = 'Project',
          indent = 1, height = long_project_name() and 3 or 6,
          cmd = project_header(),
          enabled = big_viewport() and is_git_project(),
          key = 'e', action = ';e',
        },
        {
          icon = ' ', title = 'Git status',
          indent = 1, height = 6,
          cmd = 'echo && git changes',
          enabled = big_viewport() and is_git_project(),
          key = 's', action = ';g',
        },

        {
          icon = ' ', title = 'Pull requests',
          indent = 1, height = 3,
          cmd = 'echo && git prs -n',
          enabled = big_viewport() and is_git_project(),
          key = 'p', action = function()
            Snacks.picker.gh_pr()
          end,
        },

        {
          icon = ' ', title = "Notifications",
          indent = 1, height = 12,
          cmd = 'echo && git notifications',
          enabled = big_viewport() and is_git_project(),
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
