return {
  dir = '~/Repositories/davelens/taskmaster.nvim',
  name = 'taskmaster.nvim',
  cmd = { 'T' },
  keys = {
    {
      ';m',
      '<cmd>T<cr>',
      desc = 'Taskmaster',
    },
  },
  opts = {},
  enabled = function()
    return vim.fn.isdirectory(
      vim.fn.expand('~/Repositories/davelens/taskmaster.nvim')
    ) == 1
  end,
}
