return {
  dir = '~/Repositories/davelens/active_collab-nvim',
  name = 'active_collab.nvim',
  cmd = { 'AC' },
  keys = {
    { ';m', '<cmd>AC<cr>', desc = 'Time records' },
  },
  opts = {
    account_url = 'https://next-app.activecollab.com/167099',
    completions = {
      filetypes = { 'html' },
    },
  },
  enabled = function()
    return vim.fn.isdirectory(
      vim.fn.expand('~/Repositories/davelens/active_collab-nvim')
    ) == 1
  end,
}
