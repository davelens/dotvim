local grp = dvim.utils.augroup('recording')

-- Shows a message when macro recording starts for a given register.
dvim.utils.autocmd('RecordingEnter', {
  group = grp,
  callback = function()
    local reg = vim.fn.reg_recording()
    if reg ~= '' then
      vim.notify('Recording @' .. reg, vim.log.levels.INFO, { title = 'Macro' })
    end
  end,
})

-- Shows a message when macro recording stops.
dvim.utils.autocmd('RecordingLeave', {
  group = grp,
  callback = function()
    -- defer a little so reg_recording() is already cleared
    vim.schedule(function()
      vim.notify('Recording stopped', vim.log.levels.INFO, { title = 'Macro' })
    end)
  end,
})
