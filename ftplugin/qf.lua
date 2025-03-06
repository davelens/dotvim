dvim.load('config.functions.quickfix')

vim.keymap.set(
  'n',
  'sr',
  dvim.quickfix.search_replace,
  {
    buffer = true,
    noremap = true,
    desc = '[S]earch and [R]eplace in quickfix list',
  }
)
