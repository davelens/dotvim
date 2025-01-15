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

map = vim.api.nvim_buf_set_keymap
default_opts = { noremap = true, silent = false }

-- rails.vim
map(0, 'n', '<leader>a', '<cmd>A<CR>', default_opts)
map(0, 'n', '<leader>r', '<cmd>R<CR>', default_opts)

-- Snacks.picker
-- Method definition lookup. Same as <leader>l, but prefixes search string with "def "
--
-- TODO: Backport from Telescope to the Snacks picker.
--map(0, 'n', '<leader>d', ":<C-U>lua require('telescope.builtin').grep_string({search = 'def ' .. vim.fn.expand('<cword>')})<CR>", default_opts)
--map(0, 'v', '<leader>d', ":<C-U>lua require('telescope.builtin').grep_string({search = 'def ' .. get_visual_selection()})<CR>", default_opts)

map(0, 'n', '<leader>f', ':TestNearest<CR>', default_opts)

-- vim-localorie
-- See config/dvim/lua/neovim/autocommands.lua

rails = vim.api.nvim_create_augroup('rails', { clear = true })
rspec = vim.api.nvim_create_augroup('rspec', { clear = true })

vim.api.nvim_create_autocmd('CursorMoved', {
  pattern = '*.yml',
  group = 'rails',
  callback = function(_)
    print(vim.fn['localorie#expand_key']())
  end
})

vim.api.nvim_create_autocmd('BufLeave', {
  pattern = '*.yml',
  group = 'rails',
  callback = function(_)
    vim.cmd('echo ""')
  end
})

vim.api.nvim_create_autocmd('BufEnter', {
  pattern = '*_spec.rb',
  group = 'rspec',
  callback = function(_)
    -- TODO: <leader>p is already bound. Find a better set of keybinds for these
    -- sort of maps.
    map(0, 'n', '<leader>p', ":lua require('homebrew.functions.rspec').refactor_assignment_to_let()<CR>", default_opts)
  end
})
