return {
  'sindrets/winshift.nvim',
  cmd = 'WinShift',
  opts = {},
  keys = {
    { '<leader>wm', '<cmd>WinShift<cr>', desc = 'Move' },
    { '<leader>wx', '<cmd>WinShift swap<cr>', desc = 'Swap' },
    { '<leader>wk', '<cmd>WinShift up<cr>', desc = 'Move up' },
    { '<leader>wk', '<cmd>WinShift up<cr>', desc = 'Move up' },
    { '<leader>wj', '<cmd>WinShift down<cr>', desc = 'Move down' },
    { '<leader>wh', '<cmd>WinShift left<cr>', desc = 'Move left' },
    { '<leader>wl', '<cmd>WinShift right<cr>', desc = 'Move right' },
    {
      '<leader>wK',
      '<cmd>WinShift far_up<cr>',
      desc = 'Move far up',
    },
    {
      '<leader>wJ',
      '<cmd>WinShift far_down<cr>',
      desc = 'Move far down',
    },
    {
      '<leader>wH',
      '<cmd>WinShift far_left<cr>',
      desc = 'Move far left',
    },
    {
      '<leader>wL',
      '<cmd>WinShift far_right<cr>',
      desc = 'Move far right',
    },
  },
}
