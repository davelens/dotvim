-- Pandora's box with Rails workflow features
return {
  'tpope/vim-rails',
  ft = { 'ruby', 'eruby' },
  keys = {
    {
      '<leader>ra',
      '<cmd>A<cr>',
      ft = { 'ruby', 'eruby' },
      desc = 'Go to alternate file',
    },
    {
      '<leader>rr',
      '<cmd>R<cr>',
      ft = { 'ruby', 'eruby' },
      desc = 'Go to related file',
    },
  },
  -- no opts needed here since this is a pure vim plugin.
}
