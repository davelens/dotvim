-- Wrapper for running tests on different granularities
return { 
  'vim-test/vim-test',
  config = function()
    vim.g['test#strategy'] = {
      nearest = 'neovim',
      file = 'dispatch'
    }
    --TODO: override only when Docker is running and active.
    --vim.g["test#ruby#rspec#executable"] = "docker compose exec test bin/rspec"
  end
}
