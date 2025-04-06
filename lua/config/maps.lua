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
map('n', '<leader>s', '<Esc>:w<CR>', { desc = '[S]ave file' })
map('n', '<leader>x', '<Esc>:q!<CR>', { desc = 'E[x]it without saving' })

-- Do not exit visual mode when shifting
map('v', '>', '>gv', { noremap = true })
map('v', '<', '<gv', { noremap = true })

-- Less finger wrecking window navigation.
-- NOTE: using <TAB> messes with <C-i> in normal mode, since <C-i> is the same
-- as <TAB> in ASCII. I need to look into working around this, but for now
-- just leave it as is.
--map('n', '<TAB>', '<C-w>w', { desc = 'Cycle windows' })
map('n', '<C-h>', '<C-w>h', { desc = 'Move focus to the left window' })
map('n', '<C-j>', '<C-w>j', { desc = 'Move focus to the lower window' })
map('n', '<C-k>', '<C-w>k', { desc = 'Move focus to the upper window' })
map('n', '<C-l>', '<C-w>l', { desc = 'Move focus to the right window' })

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
  ':silent! w<CR>:cprev<CR>',
  { desc = 'Go to previous [Q]uickfix message' }
)
map(
  'n',
  ']q',
  ':silent! w<CR>:cnext<CR>',
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
  { desc = 'Show diagnostic [E]rror message' }
)
map(
  'n',
  '<leader>dq',
  vim.diagnostic.setqflist,
  { desc = 'Open diagnostic [Q]uickfix' }
)
