local grp = dvim.utils.augroup('ui')

-- This removes the mysterious padding around the neovim instance when the
-- terminal background is different from the one set in Neovim.
--
-- https://old.reddit.com/r/neovim/comments/1ehidxy/you_can_remove_padding_around_neovim_instance/
dvim.utils.autocmd({ 'UIEnter', 'ColorScheme' }, {
  group = grp,
  callback = function()
    local normal = vim.api.nvim_get_hl(0, { name = 'Normal' })
    if not normal.bg then
      return
    end
    io.write(string.format('\027]11;#%06x\027\\', normal.bg))
  end,
})
dvim.utils.autocmd('UILeave', {
  group = grp,
  callback = function()
    io.write('\027]111\027\\')
  end,
})
