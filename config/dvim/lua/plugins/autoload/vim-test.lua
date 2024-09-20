-- Wrapper for running tests on different granularities
return { 
  'vim-test/vim-test',
  config = function()
    vim.g['test#strategy'] = {
      nearest = 'neovim',
      file = 'dispatch'
    }
  end
}
