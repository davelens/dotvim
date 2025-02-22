local quickfix = {}

-- I have to rethink this entire flow and ideally trigger this from within the
-- Snacks picker. There are some quirks.
function quickfix.search_replace(query, replace)
  dvim.cursor.remember_position()

  if query == nil or query == '' then
    search_ok, query = pcall(vim.fn.input, 'Search for: ')

    if not search_ok or query == nil or query == '' then
      vim.cmd('ccl')
      return print_redraw('Search cancelled')
    end
  end

  if replace == nil or replace == '' then
    replace_ok, replace = pcall(vim.fn.input, 'Replace with: ')

    if not replace_ok or replace == nil or replace == '' then
      vim.cmd('ccl')
      return print_redraw('Replace cancelled')
    end
  end

  vim.cmd(string.format("cdo execute 's/%s/%s/gc'", query, replace))
  vim.cmd('cfdo update')

  dvim.cursor.restore_position()
  dvim.buffers.delete_quickfix()
  vim.cmd('ccl')
end

return quickfix
