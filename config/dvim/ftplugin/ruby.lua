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

vim.api.nvim_create_autocmd('BufEnter', {
  pattern = '*.rb,*.erb,*.html.erb',
  callback = function(args)
    map = vim.keymap.set
    default_opts = { noremap = true, silent = false, buffer = args.buf }

    -- rails.vim
    map('n', '<leader>a', '<cmd>A<CR>', default_opts)
    map('n', '<leader>r', '<cmd>R<CR>', default_opts)
        
    -- Telescope
    -- Method definition lookup. Same as <leader>l, but prefixes search string with "def "
    map('n', '<leader>d', ":<C-U>lua require('telescope.builtin').grep_string({search = 'def ' .. vim.fn.expand('<cword>')})<CR>", default_opts)
    map('v', '<leader>d', ":<C-U>lua require('telescope.builtin').grep_string({search = 'def ' .. get_visual_selection()})<CR>", default_opts)

    -- vim-localorie bindings
    map('n', '<leader>yt', ":lua vim.fn['localorie#translate']()<CR>", default_opts)
    map('n', '<leader>ye', ":lua print(vim.fn['localorie#expand_key']())<CR>", default_opts)
    --map('v', '<leader>yt', ":lua vim.fn['localorie#translate']()<CR>", default_opts)
    --map('v', '<leader>i', ':<C-U>lua print(get_visual_selection())<CR>', { noremap = true, silent = true, buffer = true })
    --vnoremap <leader>i "ky:echo system("~/.bin/rails/lookup-translations ". @k)<CR>
  end
})

local rails = vim.api.nvim_create_augroup('rails', { clear = true })

vim.api.nvim_create_autocmd('CursorMoved', {
  pattern = '*.yml',
  group = rails,
  callback = function(_)
    print(vim.fn['localorie#expand_key']())
  end
})

vim.api.nvim_create_autocmd('BufLeave', {
  pattern = '*.yml',
  group = rails,
  callback = function(_)
    vim.cmd('echo ""')
  end
})
