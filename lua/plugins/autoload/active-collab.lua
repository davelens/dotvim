return {
  'davelens/active_collab-nvim',
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
}
