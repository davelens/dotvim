local M = {}

-- Checks or unchecks markdown checkboxes (`- [ ]`).
function M.toggle_state()
  local bufnr = vim.api.nvim_get_current_buf()
  local row = vim.api.nvim_win_get_cursor(0)[1] - 1
  local line = vim.api.nvim_buf_get_lines(bufnr, row, row + 1, false)[1]
  if not line then
    return
  end

  local toggled = line:gsub('%- %[ %]', '- [x]', 1)
  if toggled == line then
    toggled = line:gsub('%- %[x%]', '- [ ]', 1)
  end
  if toggled ~= line then
    vim.api.nvim_buf_set_lines(bufnr, row, row + 1, false, { toggled })
  end
end

function M.toggle_file()
  local todo_path = vim.fn.expand('./.notes/todo.md')

  -- Make sure the full path + file exists.
  if vim.fn.filereadable(todo_path) == 0 then
    local notes_dir = vim.fn.fnamemodify(todo_path, ':h')
    if vim.fn.isdirectory(notes_dir) == 0 then
      vim.fn.mkdir(notes_dir, 'p')
    end

    local fd = io.open(todo_path, 'w')
    if fd then
      fd:write('# TODO\n\n- [] ')
      fd:close()
    end
  end

  vim.cmd('edit ' .. vim.fn.fnameescape(todo_path))

  -- Move to the first uncompleted todo (`- [ ] `).
  local bufnr = vim.api.nvim_get_current_buf()
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  for idx, line in ipairs(lines) do
    if line:match('^- %[ %]') then
      vim.api.nvim_win_set_cursor(0, { idx, 0 })
      break
    end
  end
end

return M
