local quickfix = {}

function quickfix.search_replace(term)
  local cursor = require('homebrew/functions/cursor')
  local old_value = vim.fn.escape(term, '/')
  local new_value = vim.fn.escape(
    vim.fn.input('Replace' .. vim.fn.shellescape(term) .. ' with: '),
    '/'
  )

  cursor.remember_position()

  if vim.fn.empty(vim.fn.getqflist()) ~= 1 then
    vim.cmd("cdo execute '%s/'".. old_value ..'/'.. new_value ..'/gc')
    vim.cmd('cexpr []')
  else
    vim.cmd([[execute '%s/'. old_value .'/'. new_value .'/gc']])
  end

  vim.cmd('wa')
  vim.cmd('ccl')

  cursor.restore_position()
end

return quickfix
