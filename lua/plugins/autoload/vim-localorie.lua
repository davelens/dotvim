-- Maps and functions for Rails I18n interaction
return {
  'airblade/vim-localorie',
  ft = { 'ruby', 'eruby', 'yaml', 'eruby.yaml' },
  keys = {
    {
      "<leader>t",
      function() vim.fn['localorie#translate']() end,
      desc = "Find I18n [t]ranslation",
      ft = { "ruby", "eruby" }
    },
  },
  init = function()
    local group = vim.api.nvim_create_augroup('vim-localorie', { clear = true })

    vim.api.nvim_create_autocmd('CursorMoved', {
      pattern = '*.yml',
      group = group,
      callback = function(_)
        print(vim.fn['localorie#expand_key']())
      end
    })
  end
}
