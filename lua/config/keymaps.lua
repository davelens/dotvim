local map = vim.keymap.set

-- Copy system clipboard
map('n', '<C-y>', '"+y', { desc = 'Yank to system clipboard' })
map('v', '<C-y>', '"+y', { desc = 'Yank to system clipboard' })

-- Quick save and exit
map('n', '<leader>s', '<cmd>w<CR>', { desc = 'Save file' })
map('n', '<leader>x', '<cmd>q!<CR>', { desc = 'Close file without saving' })

-- Do not exit visual mode when shifting
map('v', '>', '>gv', { noremap = true })
map('v', '<', '<gv', { noremap = true })

-- Less finger wrecking window navigation.
map('n', '<C-h>', '<C-w>h', { desc = 'Move focus to the left window' })
map('n', '<C-j>', '<C-w>j', { desc = 'Move focus to the lower window' })
map('n', '<C-k>', '<C-w>k', { desc = 'Move focus to the upper window' })
map('n', '<C-l>', '<C-w>l', { desc = 'Move focus to the right window' })
-- NOTE: mapping <TAB> messes with <C-i> in normal mode, since that's the
-- equivalent of <TAB> in ASCII. Just use <C-w>w for now.
--map('n', '<TAB>', '<C-w>w', { desc = 'Cycle windows' })

-- Resize buffers into a certain direction.
map('n', '<S-h>', function()
  dvim.buffers.shift_width('left')
end, { desc = 'Shift width to the left' })

map('n', '<S-l>', function()
  dvim.buffers.shift_width('right')
end, { desc = 'Shift width to the right' })

map('n', '+', function()
  dvim.buffers.shift_width('up')
end)

map('n', '-', function()
  dvim.buffers.shift_width('down')
end)

-- Clear search highlighting when pressing <Esc>
map('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Buffer maps
-- NOTE: Renaming is sort of deprecated due to oil.nvim. The latter is
-- "smart" in that it has some LSP tie-ins.
map(
  'n',
  '<leader>br',
  dvim.buffers.rename_file,
  { desc = 'Rename current', noremap = true, silent = true }
)
map(
  'n',
  '<leader>bc',
  dvim.buffers.delete_hidden,
  { desc = 'Clean hidden', noremap = true, silent = true }
)
map(
  'n',
  '<leader>by',
  dvim.buffers.copy_filepath,
  { desc = 'Yank relative filepath', noremap = true, silent = true }
)
-- stylua: ignore
map(
  'n',
  '<leader>bY',
  function()
    dvim.buffers.copy_filepath({ absolute = true })
  end,
  { desc = 'Yank absolute filepath', noremap = true, silent = true }
)

-- Quickfix maps
map('n', '<leader>qc', function()
  vim.fn.setqflist({})
end, { desc = 'Clear list', noremap = true, silent = true })

-- Diagnostic maps
map('n', '<leader>df', vim.diagnostic.open_float, { desc = 'List in float' })
map('n', '<leader>dq', vim.diagnostic.setqflist, { desc = 'List in quickfix' })

map(
  'n',
  'q',
  dvim.load('config.functions.q').handler,
  -- The expr is either '' or 'q' depending on the buffer state.
  { expr = true, desc = 'Close special filetype buffer(s)' }
)

map(
  'n',
  ';t',
  dvim.load('config.functions.todo').toggle_file,
  { desc = 'TODO list' }
)
