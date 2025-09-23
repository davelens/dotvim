local group = dvim.utils.augroup('custom-filetypes')

dvim.utils.autocmd('CursorMoved', {
  group = group,
  pattern = 'todo.md',
  callback = function()
    vim.bo.filetype = 'TODO'
  end,
})
