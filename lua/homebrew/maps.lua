local map = vim.keymap.set

-- Copy to/cut/paste from system clipboard
-- Originally inspired by
-- http://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
for _, mode in ipairs { 'n', 'v' } do
  map(mode, '<C-y>', '"+y', { desc = 'yank to system clipboard' })
  map(mode, '<leader>p', '"+p', { desc = 'paste from system clipboard after cursor' })
  map(mode, '<leader>P', '"+P', { desc = 'paste from system clipboard before cursor' })
end

-- Quick save and exit
map('n', '<leader>s', '<Esc>:w<CR>')
map('n', '<leader>x', '<Esc>:q!<CR>')

-- Do not exit visual mode when shifting
map('v', '>', '>gv', { noremap = true })
map('v', '<', '<gv', { noremap = true })

-- Hop from method to method.
map('n', '<C-n>', ']]')
map('n', '<C-p>', '[[')

-- Less finger wrecking window navigation.
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
map('n', '<leader>br', ":lua require('homebrew.functions.buffers').rename_file()<CR>", { desc = '[R]ename current buffer', noremap = true, silent = true })
map('n', '<leader>bc', ":lua require('homebrew.functions.buffers').delete_hidden()<CR>", { desc = '[C]lean up hidden buffers', noremap = true, silent = true })

-- Diagnostic maps
map('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
map('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
map('n', '<leader>de', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror message' })
map('n', '<leader>dq', vim.diagnostic.setqflist, { desc = 'Open diagnostic [Q]uickfix' })

-- Quickfix/Trouble maps
map('n', '<leader>qc', function() vim.cmd(require('trouble').is_open() and "Trouble close" or "ccl") end, { desc = 'Close Quickfix or Trouble windows' })
