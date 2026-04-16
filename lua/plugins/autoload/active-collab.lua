return {
  dir = '~/Repositories/davelens/active-collab.nvim',
  name = 'active_collab.nvim',
  cmd = { 'AC' },
  keys = {
    {
      ';m',
      '<cmd>AC<cr>',
      desc = 'Time records',
    },
  },
  ac_tui_config_path = '~/.config/ac-tui/config.toml',
  account_url = 'https://next-app.activecollab.com/167099',
  time_records = {
    default_branch = 'develop',
    ui_width = 120,
    ui_height = 30,
    billable_by_default = true,
  },
  completions = {
    filetypes = { 'html' },
    conceal = true,
  },
  enabled = function()
    return vim.fn.isdirectory(
      vim.fn.expand('~/Repositories/davelens/active-collab.nvim')
    ) == 1
  end,
}
