return {
  'davelens/rails-routes.nvim',
  ft = { 'ruby', 'eruby' },
  opts = {},
  keys = {
    {
      '<C-k>',
      '<cmd>RailsRoutes complete<cr>',
      ft = { 'ruby', 'eruby' },
      desc = 'Autocomplete route',
      mode = { 'i' },
    },
    {
      '<leader>rr',
      '<cmd>RailsRoutes definition<cr>',
      ft = { 'ruby', 'eruby' },
      desc = 'Go to route definition',
    },
    {
      '<leader>ri',
      '<cmd>RailsRoutes index<cr>',
      ft = { 'ruby', 'eruby' },
      desc = 'Index routes',
    },
  },
}
