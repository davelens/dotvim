-- Indentation and whitespace defaults
-- See this screencast to learn how these interoperate:
-- http://vimcasts.org/episodes/tabs-and-spaces/
vim.opt_local.autoindent = true -- Copy indents from current line when moving to a new line
vim.opt_local.cindent = true -- Automatic C-style indenting for non-C files
vim.opt_local.expandtab = true -- Forces spaces instead of tab characters
vim.opt_local.shiftwidth = 2 -- Use 2 spaces as default indent width when using << >>
vim.opt_local.smartindent = true -- Smart(ish) autoindenting when starting a new line
-- Inserts/Deletes whitespace in front of lines according to the above settings
vim.opt_local.smarttab = true
vim.opt_local.softtabstop = 2 -- Determines how much whitespace is used while indenting
vim.opt_local.tabstop = 2 -- The width of a tab character

local map = vim.keymap.set
map('n', '<leader>a', '<cmd>A<cr>', { silent = true, buffer = true })
map('n', '<leader>r', '<cmd>R<cr>', { silent = true, buffer = true })

-- Method definition lookup. Same as <leader>l, but prefixes search string with "def "
map('n', '<leader>d', ":<C-U>lua require('telescope.builtin').grep_string({search = 'def ' .. vim.fn.expand('<cword>')})<CR>", { noremap = true, silent = true, buffer = true })
map('v', '<leader>d', ":<C-U>lua require('telescope.builtin').grep_string({search = 'def ' .. get_visual_selection()})<CR>", { noremap = true, silent = true, buffer = true })
