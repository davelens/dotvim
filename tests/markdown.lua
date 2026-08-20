vim.opt.runtimepath:append(vim.fn.getcwd())

local markdown = require('config.functions.markdown')

for level = 1, 6 do
  vim.cmd('enew!')
  vim.api.nvim_buf_set_lines(0, 0, -1, false, {
    '[Aetala](#the-innkeeper)',
    '',
    string.rep('#', level) .. ' The Innkeeper',
  })
  vim.api.nvim_win_set_cursor(0, { 1, 2 })

  markdown.enter()

  assert(vim.api.nvim_win_get_cursor(0)[1] == 3)
end
