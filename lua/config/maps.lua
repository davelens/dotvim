local map = vim.keymap.set

-- Copy to/cut/paste from system clipboard
-- Originally inspired by
-- http://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
for _, mode in ipairs { 'n', 'v' } do
  map(mode, '<C-y>', '"+y', { desc = '[Y]ank to system clipboard' })
  map(mode, '<leader>p', '"+p', { desc = '[P]aste from system clipboard after cursor' })
  map(mode, '<leader>P', '"+P', { desc = '[P]aste from system clipboard before cursor' })
end

-- Quick save and exit
map('n', '<leader>s', '<Esc>:w<CR>', { desc = '[S]ave file' })
map('n', '<leader>x', '<Esc>:q!<CR>', { desc = 'E[x]it without saving' })

-- Do not exit visual mode when shifting
map('v', '>', '>gv', { noremap = true })
map('v', '<', '<gv', { noremap = true })

-- Hop from method to method.
map('n', '<C-n>', ']]')
map('n', '<C-p>', '[[')

-- Less finger wrecking window navigation.
map('n', '<TAB>', '<C-w>w', { desc = 'Cycle windows' })
map('n', '<C-h>', '<C-w>h', { desc = 'Move focus to the left window' })
map('n', '<C-j>', '<C-w>j', { desc = 'Move focus to the lower window' })
map('n', '<C-k>', '<C-w>k', { desc = 'Move focus to the upper window' })
map('n', '<C-l>', '<C-w>l', { desc = 'Move focus to the right window' })

-- Toggles search highlighting
map('n', '<F3>', ':set hlsearch!<CR>')

-- Clear search highlighting when pressing <Esc>
map('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Easy paste/nopaste
map('n', '<F5>', ':set paste<CR>')
map('n', '<F6>', ':set nopaste<CR>')

-- Underline current line
map('n', '<leader>=', 'yypVr=')
map('n', '<leader>-', 'yypVr-')
map('n', '<leader>*', 'yypVr*')

-- Buffer maps
map('n', '<leader>br', dvim.buffers.rename_file, { desc = '[R]ename current buffer', noremap = true, silent = true })
map('n', '<leader>bc', dvim.buffers.delete_hidden, { desc = '[C]lean up hidden buffers', noremap = true, silent = true })

-- Diagnostic maps
map('n', '[q', ':silent! w<CR>:cprev<CR>', { desc = 'Go to previous [Q]uickfix message' })
map('n', ']q', ':silent! w<CR>:cnext<CR>', { desc = 'Go to next [Q]uickfix message' })
map('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
map('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
map('n', '<leader>de', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror message' })
map('n', '<leader>dq', vim.diagnostic.setqflist, { desc = 'Open diagnostic [Q]uickfix' })
