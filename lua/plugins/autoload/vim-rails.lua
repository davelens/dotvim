-- Pandora's box with Rails workflow features
return {
  'tpope/vim-rails',
  ft = { 'ruby', 'eruby' },
  keys = {
    {
      '<leader>a',
      '<cmd>A<cr>',
      ft = { 'ruby', 'eruby' },
      desc = 'Switch to [A]lternate file',
    },
    {
      '<leader>r',
      '<cmd>R<cr>',
      ft = { 'ruby', 'eruby' },
      desc = 'Switch to [R]elated file',
    },
  },
  -- no opts needed here since this is a pure vim plugin.
}
