-- Git wrapper for (n)vim.
return {
  'tpope/vim-fugitive',
  cmd = 'Git',
  keys = {
    { ';g', '<cmd>G<cr>', desc = 'Git (vim-fugitive)' },
    {
      '<leader>ga',
      '<cmd>G add %<cr>',
      desc = 'Add current buffer to stage',
    },
    {
      '<leader>gp',
      '<cmd>G add -p %<cr>',
      desc = 'Add patches to stage',
    },
    {
      '<leader>gc',
      '<cmd>G commit<cr>',
      desc = 'Commit staged files',
    },
    {
      '<leader>gr',
      '<cmd>G rebase -i<cr>',
      desc = 'Interactive rebase',
    },
    { 'gu', '<cmd>Git pull<cr>', ft = 'fugitive', desc = '[G]it p[u]ll' },
    { 'gp', '<cmd>Git push<cr>', ft = 'fugitive', desc = '[G]it [p]ush' },
  },
  -- no opts needed here since this is a pure vim plugin.
}
