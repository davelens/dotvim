local cursor = {}

function cursor.remember_position()
  vim.g.cursor_file = vim.fn.expand('%')
  vim.g.cursor_pos = vim.fn.getpos('.')
end

function cursor.restore_position()
  vim.cmd('e ' .. vim.g.cursor_file)
  vim.api.nvim_win_set_cursor(0, { vim.g.cursor_pos[2], vim.g.cursor_pos[3] })
end

return cursor
