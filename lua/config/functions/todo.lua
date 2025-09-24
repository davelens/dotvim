-- Ensure the todo file and its directory exist, creating them if necessary.
local function ensure_todo_file()
  local todo_path = vim.fn.expand('./.notes/todo.md')

  if vim.fn.filereadable(todo_path) == 0 then
    local notes_dir = vim.fn.fnamemodify(todo_path, ':h')

    if vim.fn.isdirectory(notes_dir) == 0 then
      vim.fn.mkdir(notes_dir, 'p')
    end

    local fd = io.open(todo_path, 'w')

    if fd then
      fd:write('# TODO\n\n- [ ] ')
      fd:close()
    end
  end

  return todo_path
end

-- Open the given buffer in a floating window and return the window id.
local function open_todo_float(buf)
  local width = math.floor(vim.o.columns * 0.6)
  local height = math.floor(vim.o.lines * 0.6)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  return vim.api.nvim_open_win(buf, true, {
    relative = 'editor',
    width = width,
    height = height,
    row = row,
    col = col,
    style = 'minimal',
    border = 'single',
  })
end

-- Move the cursor to the first uncompleted todo in the buffer.
local function move_to_first_uncompleted_todo(bufnr)
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

  for i, line in ipairs(lines) do
    if line:match('%- %[ %]') then
      vim.api.nvim_win_set_cursor(0, { i, 0 })
      return
    end
  end
end

-------------------------------------------------------------------------------

local M = {
  float_id = nil,
}

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
  if M.float_id and vim.api.nvim_win_is_valid(M.float_id) then
    vim.api.nvim_win_close(M.float_id, true)
    M.float_id = nil
    return
  end

  local todo_path = ensure_todo_file()
  local buf = vim.fn.bufnr(todo_path, true)
  vim.fn.bufload(buf)

  -- Set the buffer to be unlisted and wipe on hide so it doesn't persist
  vim.api.nvim_buf_set_option(buf, 'buflisted', false)
  vim.api.nvim_buf_set_option(buf, 'bufhidden', 'wipe')

  M.float_id = open_todo_float(buf)
  move_to_first_uncompleted_todo(buf)
end

return M
