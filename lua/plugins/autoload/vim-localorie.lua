-- Maps and functions for Rails I18n interaction
return {
  'airblade/vim-localorie',
  ft = { 'ruby', 'eruby', 'yaml', 'eruby.yaml' },
  keys = {
    {
      '<leader>fi',
      function()
        vim.fn['localorie#translate']()
      end,
      desc = '[F]ind [I]18n translation',
      ft = { 'ruby', 'eruby' },
    },
  },
  init = function()
    local group = dvim.utils.augroup('vim-localorie')

    -- Shows the fully concatenated I18n identifier.
    dvim.utils.autocmd('CursorMoved', {
      group = group,
      pattern = '*.yml',
      callback = function(_)
        print(vim.fn['localorie#expand_key']())
      end,
    })

    -- Clean up the input line.
    dvim.utils.autocmd('BufLeave', {
      group = group,
      pattern = '*.yml',
      callback = function(_)
        vim.cmd('echo ""')
      end,
    })
  end,
}
