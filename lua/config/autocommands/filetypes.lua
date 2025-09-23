local grp = dvim.utils.augroup('filetypes')

-- Reserve <CR> for running :TestFile in Ruby, Elixir, and JavaScript files
dvim.utils.autocmd('FileType', {
  group = grp,
  pattern = { 'ruby', 'javascript' },
  callback = function()
    vim.keymap.set(
      'n',
      '<CR>',
      '<cmd>TestFile<cr>',
      { buffer = true, noremap = true, silent = true }
    )
  end,
})

-- Unmap <CR> in Command-line mode, including for vim and terminal buffers
dvim.utils.autocmd('FileType', {
  group = grp,
  pattern = { 'vim' },
  callback = function()
    dvim.utils.nvim_buf_safe_del_keymap(0, 'n', '<CR>')
  end,
})

-- Map <leader>; to run buffers#append_semicolon() in JS files.
dvim.utils.autocmd('FileType', {
  group = grp,
  pattern = {
    'javascript',
    'javascriptreact',
    'typescript',
    'typescriptreact',
    'css',
    'scss',
  },
  callback = function()
    vim.keymap.set(
      'n',
      '<leader>;',
      dvim.buffers.append_semicolon,
      { buffer = true, silent = true }
    )
  end,
})

dvim.utils.autocmd('FileType', {
  group = grp,
  pattern = { 'markdown', 'text' },
  callback = function()
    vim.keymap.set(
      'n',
      '<CR>',
      require('config.functions.todo').toggle_state,
      { buffer = true, silent = true }
    )
  end,
})
