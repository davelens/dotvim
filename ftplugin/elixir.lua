-- Toggles the terminal buffer and runs the current file in Elixir.
function toggle_elixir_runner()
  vim.cmd('w')
  vim.cmd('split | terminal elixir ' .. vim.fn.shellescape(vim.fn.expand("%")))
  vim.cmd('startinsert')
end

-- Keymap for .ex and .exs files
vim.keymap.set('n', '<CR>', '<cmd>lua toggle_elixir_runner()<CR>', { noremap = true, silent = true, buffer = true })
