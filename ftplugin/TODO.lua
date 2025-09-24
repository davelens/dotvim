local group = dvim.utils.augroup('ft-TODO')

-- Autosave when leaving todo.md or TODO.md.
dvim.utils.autocmd({ 'BufLeave', 'BufUnload', 'FocusLost' }, {
  group = group,
  pattern = { 'todo.md', 'TODO.md' },
  callback = function()
    if vim.bo.modified then
      vim.cmd('write')
    end
  end,
})

-- Check the current line for a markdown checkbox, and inserts a blank one
-- for a given key ("\n" for <CR>, but otherwise just "o" and "O").
local function insert_checkbox(key)
  local line = vim.api.nvim_get_current_line()
  local is_checkbox = line:match('^%s*%- %[[^%]]%] ')
  return is_checkbox and key .. '- [ ] ' or key
end

opts = { buffer = true, expr = true }
vim.keymap.set('i', '<CR>', function()
  return insert_checkbox('\n')
end, opts)

vim.keymap.set('n', 'o', function()
  return insert_checkbox('o')
end, opts)

vim.keymap.set('n', 'O', function()
  return insert_checkbox('O')
end, opts)
