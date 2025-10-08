-- Git wrapper for (n)vim.
return {
  'tpope/vim-fugitive',
  cmd = { 'Git', 'GRemove' },
  keys = {
    { ';g', '<cmd>G<cr>', desc = 'Git (vim-fugitive)' },
    { '<leader>ga', '<cmd>G add %<cr>', desc = 'Stage current buffer' },
    { '<leader>gb', '<cmd>G blame<cr>', desc = 'Blame / praise' },
    { '<leader>gp', '<cmd>G add -p %<cr>', desc = 'Add patches to stage' },
    { '<leader>gP', '<cmd>G push<cr>', desc = 'Push' },
    { '<leader>gU', '<cmd>G pull<cr>', desc = 'Pull' },
    { '<leader>gc', '<cmd>G commit<cr>', desc = 'Commit staged files' },
    { '<leader>gr', '<cmd>G rebase -i<cr>', desc = 'Interactive rebase' },
    {
      '<leader>gs',
      function()
        vim.cmd('terminal git s')
        vim.api.nvim_feedkeys('i', 'n', false) -- Enter insert mode

        vim.api.nvim_create_autocmd('TermClose', {
          buffer = 0,
          once = true,
          callback = function()
            vim.cmd('bdelete!')
          end,
        })
      end,
      desc = 'Switch branch',
    },
    { 'gu', '<cmd>Git pull<cr>', ft = 'fugitive', desc = 'Pull' },
    { 'gp', '<cmd>Git push<cr>', ft = 'fugitive', desc = 'Push' },
    { ';g', '<cmd>q<cr>', ft = 'fugitive', desc = 'Git (close)' },
  },
  -- no opts needed here since this is a pure vim plugin.
}
