local group = dvim.utils.augroup('ft-TODO')

dvim.utils.autocmd({ 'BufLeave', 'BufUnload', 'FocusLost' }, {
  group = group,
  pattern = { 'todo.md', 'TODO.md' },
  callback = function()
    if vim.bo.modified then
      vim.cmd('write')
    end
  end,
})

-- Typing Enter on a line beginning with `- [*]` will start a new line prefixed
-- with a blank checkbox.
function insert_checkbox(line)
  line = line or vim.api.nvim_get_current_line()
  local prefix = line:match('^%s*%- %[[^%]]%] ')
  if prefix then
    return '\n- [ ] '
  else
    return '\n'
  end
end

vim.keymap.set('i', '<CR>', insert_checkbox, { buffer = true, expr = true })
