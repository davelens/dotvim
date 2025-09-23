local map = vim.keymap.set

-- Copy to/cut/paste from system clipboard
-- Originally inspired by
-- http://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
for _, mode in ipairs({ 'n', 'v' }) do
  map(mode, '<C-y>', '"+y', { desc = '[Y]ank to system clipboard' })
  map(
    mode,
    '<leader>p',
    '"+p',
    { desc = '[P]aste from system clipboard after cursor' }
  )
  map(
    mode,
    '<leader>P',
    '"+P',
    { desc = '[P]aste from system clipboard before cursor' }
  )
end

-- Quick save and exit
map('n', '<leader>s', '<cmd>w<CR>', { desc = '[S]ave file' })
map('n', '<leader>x', '<cmd>q!<CR>', { desc = 'E[x]it without saving' })

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
map(
  'n',
  '<leader>br',
  dvim.buffers.rename_file,
  { desc = '[R]ename current buffer', noremap = true, silent = true }
)
map(
  'n',
  '<leader>bc',
  dvim.buffers.delete_hidden,
  { desc = '[C]lean up hidden buffers', noremap = true, silent = true }
)

-- Quickfix maps
map('n', '<leader>qc', function()
  vim.fn.setqflist({})
end, { desc = '[Q]uickfix [c]lear list', noremap = true, silent = true })

-- Diagnostic maps
map(
  'n',
  '[q',
  '<cmd>silent! w<CR><cmd>cprev<CR>',
  { desc = 'Go to previous [Q]uickfix message' }
)
map(
  'n',
  ']q',
  '<cmd>silent! w<CR><cmd>cnext<CR>',
  { desc = 'Go to next [Q]uickfix message' }
)
map(
  'n',
  '[d',
  vim.diagnostic.goto_prev,
  { desc = 'Go to previous [D]iagnostic message' }
)
map(
  'n',
  ']d',
  vim.diagnostic.goto_next,
  { desc = 'Go to next [D]iagnostic message' }
)
map(
  'n',
  '<leader>de',
  vim.diagnostic.open_float,
  { desc = 'Show [D]iagnostic [E]rror message' }
)
map(
  'n',
  '<leader>dq',
  vim.diagnostic.setqflist,
  { desc = 'Open [D]iagnostic [Q]uickfix' }
)

map(
  'n',
  'q',
  dvim.load('config.functions.q').handler,
  { expr = true, desc = 'Close special filetype buffer(s)' }
)

map(
  'n',
  '<leader>td',
  require('config.functions.todo').toggle_file,
  { desc = '[T]oggle TODO file' }
)
