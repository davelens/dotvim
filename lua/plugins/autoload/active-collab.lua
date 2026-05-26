return {
  'davelens/active_collab-nvim',
  -- dir = '~/Repositories/davelens/active_collab-nvim',
  -- name = 'active_collab.nvim',
  cmd = { 'AC' },
  keys = {
    { ';m', '<cmd>AC<cr>', desc = 'Time records' },
    { '<leader>gpr', '<cmd>AC pr<cr>', desc = 'Pull request' },
  },
  opts = {
    account_url = 'https://next-app.activecollab.com/167099',
    completions = {
      filetypes = { 'html' },
    },
  },
}
