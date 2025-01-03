-- Git wrapper for (n)vim.
return {
  "tpope/vim-fugitive",
  lazy = false, -- Needs to always be active.
  keys = { 
    { "<leader>g", "<cmd>G<cr>" },
  },
  config = function()
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "fugitive",
      callback = function()
        vim.api.nvim_buf_set_keymap(0, 'n', 'gu', ':Git pull<CR>', { noremap = true, silent = true })
      end,
    })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "fugitive",
      callback = function()
        vim.api.nvim_buf_set_keymap(0, 'n', 'gp', ':Git push<CR>', { noremap = true, silent = true })
      end,
    })
  end
}
