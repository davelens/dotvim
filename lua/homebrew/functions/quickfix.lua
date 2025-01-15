local quickfix = {}

-- I have to rethink this entire flow and ideally trigger this from within the
-- Snacks picker. There are some quirks.
function quickfix.search_replace(query, replace)
  buffers = require('homebrew.functions.buffers')
  cursor = require('homebrew.functions.cursor')
  cursor.remember_position()

  if query == nil or query == '' then
    query = vim.fn.input('Search for: ')

    if query == nil or query == '' then
      nvim_cli_clear_last_message()
      vim.cmd('ccl')
      return
    end
  end

  if replace == nil or replace == '' then
    replace = vim.fn.input('Replace with: ')
  end

  vim.cmd(string.format("cdo execute 's/%s/%s/gc'", query, replace))
  vim.cmd('cfdo update')

  cursor.restore_position()
  buffers.delete_quickfix()
  vim.cmd('ccl')
end

return quickfix
