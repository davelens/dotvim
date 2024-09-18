local buffers = {}

-- Clean up and wipeout all hidden buffers.
function buffers.delete_hidden()
  -- Get all buffers that are visible in all tab pages
  local tpbl = {}

  -- Iterate through each tab and collect the visible buffers
  for tab = 1, vim.fn.tabpagenr('$') do
    local tab_buffers = vim.fn.tabpagebuflist(tab)
    vim.list_extend(tpbl, tab_buffers)
  end

  -- Iterate through all buffers and wipeout the hidden ones
  for buf = 1, vim.fn.bufnr('$') do
    if vim.fn.bufexists(buf) == 1 and vim.fn.index(tpbl, buf) == -1 then
      vim.cmd('silent bwipeout ' .. buf)
    end
  end
end

-- Rename the current file in your buffer.
function buffers.rename_file()
  local old_name = vim.fn.expand('%')
  local new_name = vim.fn.input('Rename to: ', old_name, 'file')
  
  if new_name == '' or new_name == old_name then
    return
  end

  os.rename(old_name, new_name)

  -- Delete the old buffer, reopen the new file, redraw the screen
  vim.cmd('bdelete ' .. old_name)
  vim.cmd('e ' .. new_name)
  vim.cmd('redraw')

  print('Renamed ' .. old_name .. ' to ' .. new_name)
end

return buffers

