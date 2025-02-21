-- Pandora's box with Rails workflow features
return {
  'tpope/vim-rails',
  ft = { "ruby", "eruby" },
  keys = {
    { '<leader>a', '<cmd>A<cr>' },
    { '<leader>r', '<cmd>R<cr>' }
  },
  -- no opts needed here since this is a pure vim plugin.
}
