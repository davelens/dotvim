-- Git wrapper for (n)vim.
return {
  'tpope/vim-fugitive',
  cmd = 'Git',
  keys = {
    { ';g', '<cmd>G<cr>', desc = 'Git (vim-fugitive)' },
    { 'gu', '<cmd>Git pull<cr>', ft = 'fugitive', desc = '[G]it p[u]ll' },
    { 'gp', '<cmd>Git push<cr>', ft = 'fugitive', desc = '[G]it [p]ush' },
  },
  -- no opts needed here since this is a pure vim plugin.
}
