dvim.load('config.functions.quickfix')

vim.keymap.set('n', 'sr', dvim.quickfix.find_replace, {
  buffer = true,
  noremap = true,
  desc = '[S]earch and [R]eplace in quickfix list',
})

vim.keymap.set('n', 'rf', dvim.quickfix.rename_files, {
  buffer = true,
  noremap = true,
  desc = '[R]ename [f]ile(s) from quickfix list',
})
