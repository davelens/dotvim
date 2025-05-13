return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  opts = {
    view_options = {
      show_hidden = true,
    },
  },
  keys = {
    {
      '<leader>o',
      '<cmd>Oil --float<CR>',
      silent = true,
      desc = 'Open [O]il.nvim',
    },
  },
}
