-- Typing Enter on a line beginning with `- [*]` will start a new line prefixed
-- with a blank checkbox.
vim.keymap.set('i', '<CR>', function()
  local line = vim.api.nvim_get_current_line()
  local prefix = line:match('^%s*%- %[[^%]]%] ')
  if prefix then
    return '\n- [ ] '
  else
    return '\n'
  end
end, { buffer = true, expr = true })
