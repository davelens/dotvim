local grp = dvim.utils.augroup('filetypes')

-- Reserve <CR> for running :TestFile in Ruby, Elixir, and JavaScript files
dvim.utils.autocmd('FileType', {
  group = grp,
  pattern = { 'ruby', 'javascript', 'elixir' },
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

-- Check markdown checkboxes in a list ("- [ ]" -> "- [x]")
dvim.utils.autocmd('FileType', {
  group = grp,
  pattern = { 'markdown', 'text', 'TODO' },
  callback = function()
    vim.keymap.set(
      'n',
      '<CR>',
      require('config.functions.todo').toggle_state,
      { buffer = true, silent = true }
    )
  end,
})

-- Undo the `q` keymap in CodeCompanion (CC) buffers.
-- CC comes with a dynamically mapped `q`:
-- * When no API requests are active, it is mapped to "close chat".
-- * When an API request is active, it is mapped to "stop request".
-- The issue is that a request "sometimes" seems to last indefinitely.
-- To alleviate and trust on my global `q` map for special filetypes, I have
-- unmapped `q` entirely from codecompanion buffers.
-- You can still use <Esc> to manually stop requests, if need be.
dvim.utils.autocmd('FileType', {
  group = grp,
  pattern = { 'codecompanion' },
  callback = function(args)
    pcall(vim.keymap.del, 'n', 'q', { buffer = args.buf })
  end,
})

-- vim-projectionist heuristics for a module+test file pattern.
-- This makes :A work like it does in Rails for *.rb -> *_spec.rb files.
vim.g.projectionist_heuristics = {
  ['mix.exs'] = {
    ['lib/*.ex'] = { alternate = 'test/{}_test.exs', type = 'source' },
    ['test/*_test.exs'] = { alternate = 'lib/{}.ex', type = 'test' },
  },
}
