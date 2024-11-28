local cursor = {}

function cursor.remember_position()
  vim.cmd([[let g:cursor_file = expand("%")]])
  vim.cmd([[let g:cursor_pos = getpos(".")]])
end

function cursor.restore_position()
  vim.cmd([[execute 'b ' . g:cursor_file]])
  vim.cmd([[call setpos('.', g:cursor_pos)]])
end

return cursor
