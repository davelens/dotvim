local cursor = {}

-- Uses global variables to store the previous cursor position
function cursor.remember_position()
  vim.g.prev_cursor_win = vim.api.nvim_get_current_win()
  vim.g.prev_cursor_buf = vim.api.nvim_win_get_buf(vim.g.prev_cursor_win)
  vim.g.prev_cursor_pos = vim.api.nvim_win_get_cursor(vim.g.prev_cursor_win)
end

-- Resets the cursor to its previous position.
-- Intended to work in tandem with cursor.remember_position().
function cursor.restore_position()
  -- Check if the window and buffer still exist
  if not vim.api.nvim_win_is_valid(vim.g.prev_cursor_win) or
      not vim.api.nvim_buf_is_valid(vim.g.prev_cursor_buf) then
    vim.notify(
      "Cannot restore position: Window or buffer is no longer valid",
      vim.log.levels.WARN
    )

    return
  end

  -- Switch to the previous window.
  vim.api.nvim_set_current_win(vim.g.prev_cursor_win)

  -- Ensure the buffer is still the same, otherwise reload it.
  if vim.api.nvim_get_current_buf() ~= vim.g.prev_cursor_buf then
    vim.cmd('buffer ' .. vim.g.prev_cursor_buf)
  end

  -- Restore the cursor position with an error fallback using a notification.
  local ok, err = pcall(
    vim.api.nvim_win_set_cursor,
    vim.g.prev_cursor_win,
    vim.g.prev_cursor_pos
  )

  if not ok then
    vim.notify("Error restoring cursor position: " .. err, vim.log.levels.ERROR)
  end
end

return cursor
