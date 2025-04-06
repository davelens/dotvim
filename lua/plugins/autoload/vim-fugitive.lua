-- Git wrapper for (n)vim.
return {
  'tpope/vim-fugitive',
  keys = {
    { '<leader>g', '<cmd>G<cr>', desc = 'Open vim-fu[g]itive window' },
    { 'gu', '<cmd>Git pull<cr>', ft = 'fugitive', desc = '[G]it p[u]ll' },
    { 'gp', '<cmd>Git push<cr>', ft = 'fugitive', desc = '[G]it [p]ush' },
  },
  -- no opts needed here since this is a pure vim plugin.
}
