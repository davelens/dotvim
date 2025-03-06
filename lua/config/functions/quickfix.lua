local quickfix = {}

-- Wips the quickfix list clean.
function quickfix.clear()
  vim.fn.setqflist({})
  vim.cmd('ccl')
end

-- Clean up all unusable quickfix items without a filename reference.
-- They lose their filename reference after a bwipeout.
function quickfix.sanitize()
  local qflist = vim.fn.getqflist()
  local newlist = {}

  for _, entry in ipairs(qflist) do
    if vim.fn.bufname(entry.bufnr) ~= "" then
      table.insert(newlist, entry)
    end
  end

  vim.fn.setqflist(newlist)
end

-- TODO: These are just files, so attempt directories.
function quickfix.rename_files(pattern)
  local input_ok, replacement

  input_ok, pattern = pcall(
    vim.fn.input,
    'Look for pattern: ',
    pattern or ''
  )

  if not input_ok or pattern == nil or pattern == '' then
    return dvim.utils.print_redraw('File rename cancelled')
  end

  input_ok, replacement = pcall(
    vim.fn.input,
    string.format('Replace "%s" in filename with: ', pattern)
  )

  if not input_ok or replacement == nil or replacement == '' then
    return dvim.utils.print_redraw('File rename cancelled')
  end

  gsub_subcmd = string.format(
    'string.gsub(%s, "%s", "%s")',
    'vim.fn.expand("%:t")',
    pattern,
    replacement
  )

  vim.cmd(
    string.format(
      "cdo execute 'lua dvim.buffers.rename_file(nil, %s)'",
      gsub_subcmd
    )
  )

  dvim.cursor.restore_position()
  vim.cmd('ccl')
end

-- This is bound to `sr` in the `ftplugin/qf.lua`.
function quickfix.find_replace(query, replace)
  -- Fall back to the last cword/visual selection if no query is provided.
  query = query or dvim.utils.last_word_selection()

  -- Blank query at this point = ask for input, or gtfo.
  if query == nil or query == '' then
    search_ok, query = pcall(vim.fn.input, 'Search for: ', query)
    if not search_ok or query == nil or query == '' then
      vim.cmd('ccl')
      return dvim.utils.print_redraw('Search cancelled')
    end
  end

  -- Prompt the user for the replacement string, or gtfo.
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

  -- finally run cdo + update, and teleport back to where we started.
  -- cursor.restore_position() will fail silently without a prior save.
  -- Saves happen automatically after expanding cword or visual selection.
  vim.cmd(string.format('cdo execute "s/%s/%s/gc"', query, replace))
  vim.cmd('cfdo update')
  dvim.cursor.restore_position()
  vim.cmd('ccl')
end

return quickfix
