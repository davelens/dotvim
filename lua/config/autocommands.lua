-- for _, m in ipairs({
--   'config.autocommands.ui',
--   'config.autocommands.editor',
--   'config.autocommands.filetype_testing',
--   'config.autocommands.filetype_js',
--   'config.autocommands.numbers_empty',
--   'config.autocommands.close_special',
--   'config.autocommands.recording_feedback',
-- }) do
--   pcall(require, m)
-- end

-- This removes the mysterious padding around the neovim instance when the
-- terminal background is different from the one set in Neovim.
--
-- https://old.reddit.com/r/neovim/comments/1ehidxy/you_can_remove_padding_around_neovim_instance/
local fix_instance_padding = dvim.utils.augroup('fix_instance_padding')
dvim.utils.autocmd({ 'UIEnter', 'ColorScheme' }, {
  group = fix_instance_padding,
  callback = function()
    local normal = vim.api.nvim_get_hl(0, { name = 'Normal' })
    if not normal.bg then
      return
    end
    io.write(string.format('\027]11;#%06x\027\\', normal.bg))
  end,
})
dvim.utils.autocmd('UILeave', {
  group = fix_instance_padding,
  callback = function()
    io.write('\027]111\027\\')
  end,
})

-- turn off paste mode when leaving insert
dvim.utils.autocmd('InsertLeave', {
  group = dvim.utils.augroup('truly_no_paste'),
  pattern = '*',
  command = 'set nopaste',
})

-- Momentarily highlight text upon yanking
dvim.utils.autocmd('TextYankPost', {
  group = dvim.utils.augroup('highlight_yank'),
  desc = 'Highlight when yanking (copying) text',
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Define an dvim.utils.augroup to manage the dvim.utils.autocmds
local tests_with_cr = dvim.utils.augroup('run_tests_on_enter')

-- Reserve <CR> for running :TestFile in Ruby, Elixir, and JavaScript files
dvim.utils.autocmd('FileType', {
  group = tests_with_cr,
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
  group = tests_with_cr,
  pattern = { 'vim' },
  callback = function()
    dvim.utils.nvim_buf_safe_del_keymap(0, 'n', '<CR>')
  end,
})

-- Map <leader>; to run buffers#append_semicolon() in JS files.
dvim.utils.autocmd('FileType', {
  group = dvim.utils.augroup('append_semicolon'),
  pattern = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
  callback = function()
    vim.keymap.set(
      'n',
      '<leader>;',
      dvim.buffers.append_semicolon,
      { buffer = true, silent = true }
    )
  end,
})

-- No relative number for empty buffers.
dvim.utils.autocmd('BufWinEnter', {
  callback = function()
    if
      vim.bo.buftype ~= ''
      or vim.api.nvim_buf_line_count(0) == 1
        and vim.api.nvim_buf_get_lines(0, 0, 1, false)[1] == ''
    then
      vim.opt_local.number = false
      vim.opt_local.relativenumber = false
    end
  end,
})

-- Generic buffer close toggler for qf, vim-fugitive, help, etc,...
-- Hard bound on `q`.
-- Idea taken from folke's nvim config, but altered so `q` works in any buffer.
local special_filetypes = {
  'aerial',
  'checkhealth',
  'fugitive',
  'fugitiveblame',
  'git',
  'gitsigns-blame',
  'help',
  'lspinfo',
  'neotest-output',
  'neotest-output-panel',
  'neotest-summary',
  'notify',
  'oil',
  'PlenaryTestPopup',
  'qf',
  'query',
  'snacks_notif',
}

local function q_handler()
  if vim.fn.reg_recording() ~= '' then
    return 'q'
  end

  local wins = vim.api.nvim_list_wins()
  local special_count = 0
  local gitcommit_found = false
  -- I want windows + buffers *before* scheduling.
  local special_targets = {} ---@type { win: integer, buf: integer }[]

  for _, win in ipairs(wins) do
    local buf = vim.api.nvim_win_get_buf(win)
    local ft = vim.api.nvim_buf_get_option(buf, 'filetype')
    if ft == 'gitcommit' then
      gitcommit_found = true
    end
    if vim.tbl_contains(special_filetypes, ft) then
      special_count = special_count + 1
      table.insert(special_targets, { win = win, buf = buf })
    end
  end

  if gitcommit_found then
    return 'q'
  end

  if special_count > 0 then
    if special_count == #wins then
      local cur_buf = vim.api.nvim_win_get_buf(vim.api.nvim_get_current_win())
      local cur_ft = vim.api.nvim_buf_get_option(cur_buf, 'filetype')
      local msg =
        'Closing this buffer with `q` now would exit vim (filetype `%s` is special).'
      vim.schedule(function()
        vim.notify(string.format(msg, cur_ft), vim.log.levels.ERROR)
      end)
      return ''
    end

    vim.schedule(function()
      for _, t in ipairs(special_targets) do
        -- Windows/buffers may be gone by now, so check before closing.
        if t.win and vim.api.nvim_win_is_valid(t.win) then
          pcall(vim.api.nvim_win_close, t.win, true)
        end

        if t.buf and vim.api.nvim_buf_is_valid(t.buf) then
          if Snacks then
            pcall(Snacks.bufdelete, t.buf, { force = true })
          else
            pcall(vim.api.nvim_buf_delete, t.buf, { force = true })
          end
        end
      end
    end)
    return ''
  end

  return 'q'
end

vim.keymap.set(
  'n',
  'q',
  q_handler,
  { expr = true, desc = 'Close special filetype buffer(s)' }
)

-- Show a message when macro recording starts/stops
dvim.utils.autocmd('RecordingEnter', {
  callback = function()
    local reg = vim.fn.reg_recording()
    if reg ~= '' then
      vim.notify('Recording @' .. reg, vim.log.levels.INFO, { title = 'Macro' })
    end
  end,
})

dvim.utils.autocmd('RecordingLeave', {
  callback = function()
    -- defer a little so reg_recording() is already cleared
    vim.schedule(function()
      vim.notify('Recording stopped', vim.log.levels.INFO, { title = 'Macro' })
    end)
  end,
})
