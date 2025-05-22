return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  opts = {
    float = {
      border = 'single',
      max_width = 79,
      max_height = math.floor(vim.o.lines * 0.6),
    },
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
