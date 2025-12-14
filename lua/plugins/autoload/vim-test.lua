-- Wrapper for running tests on different granularities
return {
  'vim-test/vim-test',
  ft = { 'ruby', 'elixir', 'javascript' },
  keys = {
    {
      '<leader>tn',
      '<cmd>TestNearest<cr>',
      desc = 'Nearest to cursor',
      ft = { 'ruby', 'elixir' },
    },
  },
  -- init() is necessary here since we require vim.g overrides before
  -- the module gets loaded.
  init = function()
    vim.g['test#strategy'] = {
      nearest = 'neovim',
      file = 'dispatch',
    }

    -- Tell vim-dispatch to recognize docker-prefixed test commands.
    -- This ensures dispatch uses the correct compiler for quickfix parsing,
    -- and doesn't open up the quickfix when all tests pass.
    vim.g.dispatch_compilers = {
      ['docker compose exec rails '] = '',
      ['docker compose exec rails bin/rspec'] = 'rspec',
      ['docker compose exec phoenix '] = '',
      ['docker compose exec phoenix mix test'] = 'exunit',
    }
  end,
}
