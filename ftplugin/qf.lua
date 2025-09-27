dvim.load('config.functions.quickfix')

vim.keymap.set('n', 'sr', dvim.quickfix.find_replace, {
  buffer = true,
  noremap = true,
  desc = 'Search and replace',
})

vim.keymap.set('n', 'rf', dvim.quickfix.rename_files, {
  buffer = true,
  noremap = true,
  desc = 'Rename file(s)',
})
