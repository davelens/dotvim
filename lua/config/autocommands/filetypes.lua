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
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'codecompanion',
  callback = function(args)
    pcall(vim.keymap.del, 'n', 'q', { buffer = args.buf })
  end,
})

local rails = require('config.functions.rails')
local rails_i18n = dvim.load('config.functions.rails-i18n')

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'yaml', 'eruby.yaml' },
  callback = function(_)
    if rails.present() then
      local group = dvim.utils.augroup('rails-i18n')

      dvim.utils.autocmd('CursorMoved', {
        group = group,
        pattern = '*.yml',
        callback = function(_)
          print(rails_i18n.expand_yaml_key_under_cursor())
        end,
      })
    end
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'ruby', 'eruby' },
  callback = function(_)
    vim.keymap.set('n', '<leader>fti', function()
      local cword = vim.fn.expand('<cWORD>')
      local key = cword:match('%w+%([\'"]([%w%._]+)[\'"]%)') or cword
      local items = rails_i18n.translations_quickfix_for(key)

      if items then
        vim.fn.setqflist({}, ' ', { title = 'Rails I18n', items = items })
        vim.cmd('copen')
      else
        vim.notify('No translations found for: ' .. key, vim.log.levels.INFO)
      end
    end, { buffer = true, silent = true })
  end,
})
