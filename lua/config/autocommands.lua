autocmd = vim.api.nvim_create_autocmd
function augroup(name)
  return vim.api.nvim_create_augroup('augroup' .. name, { clear = true })
end

-- This removes the mysterious padding around the neovim instance when the
-- terminal background is different from the one set in Neovim.
--
-- https://old.reddit.com/r/neovim/comments/1ehidxy/you_can_remove_padding_around_neovim_instance/
local fix_instance_padding = augroup('fix_instance_padding')
autocmd({ 'UIEnter', 'ColorScheme' }, {
  group = fix_instance_padding,
  callback = function()
    local normal = vim.api.nvim_get_hl(0, { name = 'Normal' })
    if not normal.bg then
      return
    end
    io.write(string.format('\027]11;#%06x\027\\', normal.bg))
  end,
})
autocmd('UILeave', {
  group = fix_instance_padding,
  callback = function()
    io.write('\027]111\027\\')
  end,
})

-- turn off paste mode when leaving insert
autocmd('InsertLeave', {
  group = augroup('truly_no_paste'),
  pattern = '*',
  command = 'set nopaste',
})

-- Momentarily highlight text upon yanking
autocmd('TextYankPost', {
  group = augroup('highlight_yank'),
  desc = 'Highlight when yanking (copying) text',
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Define an augroup to manage the autocmds
local tests_with_cr = augroup('run_tests_on_enter')

-- Reserve <CR> for running :TestFile in Ruby, Elixir, and JavaScript files
autocmd('FileType', {
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
autocmd('FileType', {
  group = tests_with_cr,
  pattern = { 'vim' },
  callback = function()
    nvim_buf_safe_del_keymap(0, 'n', '<CR>')
  end,
})

-- Map <leader>; to run buffers#append_semicolon() in JS files.
autocmd('FileType', {
  group = augroup('append_semicolon'),
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
vim.api.nvim_create_autocmd('BufWinEnter', {
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
}

local function q_handler()
  if vim.fn.reg_recording() ~= '' then
    return 'q'
  end

  local wins = vim.api.nvim_list_wins()
  local special_count = 0
  local gitcommit_found = false
  local special_wins = {}

  for _, win in ipairs(wins) do
    local buf = vim.api.nvim_win_get_buf(win)
    local ft = vim.api.nvim_buf_get_option(buf, 'filetype')
    if ft == 'gitcommit' then
      gitcommit_found = true
    end
    if vim.tbl_contains(special_filetypes, ft) then
      special_count = special_count + 1
      table.insert(special_wins, win)
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
      for _, win in ipairs(special_wins) do
        local buf = vim.api.nvim_win_get_buf(win)
        vim.api.nvim_win_close(win, true)

        if Snacks then
          pcall(Snacks.bufdelete, buf, { force = true })
        else
          pcall(vim.api.nvim_buf_delete, buf, { force = true })
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
