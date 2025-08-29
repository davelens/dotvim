local grp = dvim.utils.augroup('buffers')

-- No relative number for empty buffers.
dvim.utils.autocmd('BufWinEnter', {
  group = grp,
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
