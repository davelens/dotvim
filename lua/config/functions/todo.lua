local M = {}

-- Checks or unchecks markdown checkboxes (`- [ ]`).
function M.toggle()
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

return M
