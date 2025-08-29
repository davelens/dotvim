local q = {}

-- Generic buffer close toggler for qf, vim-fugitive, help, etc,...
-- Hard bound on `q`.
-- Idea taken from folke's nvim config, but altered so `q` works in any buffer.
q.special_filetypes = {
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

function q.handler()
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
    if vim.tbl_contains(q.special_filetypes, ft) then
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

return q
