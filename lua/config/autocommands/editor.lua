local grp = dvim.utils.augroup('editor')

-- Turns off paste mode when leaving insert mode.
dvim.utils.autocmd('InsertLeave', {
  group = grp,
  pattern = '*',
  command = 'set nopaste',
})

-- Momentarily highlights text when yanking.
dvim.utils.autocmd('TextYankPost', {
  group = grp,
  desc = 'Highlight when yanking (copying) text',
  callback = function()
    vim.highlight.on_yank()
  end,
})
