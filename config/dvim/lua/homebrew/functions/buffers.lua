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

return buffers
