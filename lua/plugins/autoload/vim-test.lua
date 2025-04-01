-- Wrapper for running tests on different granularities
return {
  'vim-test/vim-test',
  ft = { 'ruby', 'elixir', 'javascript' },
  keys = {
    { '<leader>tn', '<cmd>TestNearest<cr>', ft = { 'ruby', 'elixir' } },
  },
  -- init() is necessary here since we require vim.g overrides before
  -- the module gets loaded.
  init = function()
    vim.g['test#strategy'] = {
      nearest = 'neovim',
      file = 'dispatch',
    }
    --TODO: override only when Docker is running and active.
    --vim.g['test#ruby#rspec#executable'] = 'docker compose exec test bin/rspec'
  end,
}
