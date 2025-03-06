local quickfix = {}

-- I have to rethink this entire flow and ideally trigger this from within the
-- Snacks picker. There are some quirks.
function quickfix.search_replace(query, replace)
  -- Fall back to the last cword/visual selection if no query is provided.
  query = query or dvim.utils.last_word_selection()

  -- Blank query at this point = ask for input, or gtfo
  if query == nil or query == '' then
    search_ok, query = pcall(vim.fn.input, 'Search for: ', query)
    if not search_ok or query == nil or query == '' then
      vim.cmd('ccl')
      return dvim.utils.print_redraw('Search cancelled')
    end
  end

  if replace == nil or replace == '' then
    replace_ok, replace = pcall(
      vim.fn.input,
      string.format('Replace "%s" with: ', query)
    )

    if not replace_ok or replace == nil or replace == '' then
      vim.cmd('ccl')
      return dvim.utils.print_redraw('Replace cancelled')
    end
  end

  vim.cmd(string.format('cdo execute "s/%s/%s/gc"', query, replace))
  vim.cmd('cfdo update')

  dvim.cursor.restore_position()
  vim.cmd('ccl')
end

return quickfix
