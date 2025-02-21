return {
  'sindrets/winshift.nvim',
  cmd = 'WinShift',
  opts = {},
  keys = {
    { '<leader>wm', '<cmd>WinShift<cr>'      , desc = 'Move [w]indow' },
    { '<leader>wx', '<cmd>WinShift swap<cr>' , desc = 'Swap [w]indow' },
    { '<leader>wk', '<cmd>WinShift up<cr>'   , desc = 'Move [w]indow up' },
    { '<leader>wj', '<cmd>WinShift down<cr>' , desc = 'Move [w]indow down' },
    { '<leader>wh', '<cmd>WinShift left<cr>' , desc = 'Move [w]indow left' },
    { '<leader>wl', '<cmd>WinShift right<cr>', desc = 'Move [w]indow right' },
  }
}
