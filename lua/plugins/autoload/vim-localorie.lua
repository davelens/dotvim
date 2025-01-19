-- Maps and functions for Rails I18n interaction
return {
  'airblade/vim-localorie',
  lazy = true,
  ft = { 'ruby', 'eruby', 'eruby.yaml' },
  config = function()
    local group = vim.api.nvim_create_augroup('vim-localorie', { clear = true })

    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'ruby,eruby',
      group = group,
      callback = function(_)
        vim.keymap.set({ 'n', 'v' }, '<leader>yt', function()
          vim.fn['localorie#translate']()
        end, { buffer = true })
      end
    })

    vim.api.nvim_create_autocmd('CursorMoved', {
      pattern = '*.yml',
      group = group,
      callback = function(_)
        print(vim.fn['localorie#expand_key']())
      end
    })
  end
}
