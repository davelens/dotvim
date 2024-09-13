-- This solves an issue with the padding around the neovim instance when the
-- terminal background is different from the one set in Neovim. 
--
-- https://old.reddit.com/r/neovim/comments/1ehidxy/you_can_remove_padding_around_neovim_instance/
--
 --This removes that padding:
vim.api.nvim_create_autocmd({ "UIEnter", "ColorScheme" }, {
  callback = function()
    local normal = vim.api.nvim_get_hl(0, { name = "Normal" })
    if not normal.bg then
      return
    end
    io.write(string.format("\027]11;#%06x\027\\", normal.bg))
  end,
})

vim.api.nvim_create_autocmd("UILeave", {
  callback = function()
    io.write("\027]111\027\\")
  end,
})

-- vim-localorie bindings need to be in multiple Ruby-related buffers.
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'ruby,eruby',
  callback = function(_)
    map = vim.api.nvim_buf_set_keymap
    default_opts = { noremap = true, silent = false }
    map(0, 'n', '<leader>yt', ":lua vim.fn['localorie#translate']()<CR>", default_opts)
    map(0, 'n', '<leader>ye', ":lua print(vim.fn['localorie#expand_key']())<CR>", default_opts)
    map(0, 'v', '<leader>yt', ":lua vim.fn['localorie#translate']()<CR>", default_opts)
  end
})

