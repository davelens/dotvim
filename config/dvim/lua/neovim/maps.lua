local map = vim.keymap.set

-- Copy to/cut/paste from system clipboard
-- Originally inspired by
-- http://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
for _, mode in ipairs { 'n', 'v' } do
  map(mode, '<C-y>', '"+y', { desc = 'yank to system clipboard' })
  map(mode, '<leader>p', '"+p', { desc = 'paste from system clipboard after cursor' })
  map(mode, '<leader>P', '"+P', { desc = 'paste from system clipboard before cursor' })
end

-- Quick save and exit maps
map('n', '<leader>s', '<Esc>:w<CR>')
map('n', '<leader>x', '<Esc>:q!<CR>')

-- Hop from method to method.
map('n', '<C-n>', ']]')
map('n', '<C-p>', '[[')

-- Less finger wrecking window navigation.
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-h>', '<C-w>h')
map('n', '<C-l>', '<C-w>l')

-- Toggles search highlighting
map('n', '<F3>', ':set hlsearch!<CR>')
-- Easy paste/nopaste
map('n', '<F5>', ':set paste<CR>')
map('n', '<F6>', ':set nopaste<CR>')

-- Underline current line
map('n', '<leader>=', 'yypVr=')
map('n', '<leader>-', 'yypVr-')
map('n', '<leader>*', 'yypVr*')
