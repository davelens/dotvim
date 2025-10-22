return {
  dir = '~/Repositories/davelens/taskmaster.nvim',
  cmd = { 'T' },
  name = 'taskmaster.nvim',
  opts = {},
  enabled = function()
    return vim.fn.isdirectory(
      vim.fn.expand('~/Repositories/davelens/taskmaster.nvim')
    ) == 1
  end,
}
