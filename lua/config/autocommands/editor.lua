local grp = dvim.utils.augroup('editor')

-- Momentarily highlights text when yanking.
dvim.utils.autocmd('TextYankPost', {
  group = grp,
  desc = 'Highlight when yanking (copying) text',
  callback = function()
    vim.hl.on_yank()
  end,
})
