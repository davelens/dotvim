return {
  'folke/trouble.nvim',
  opts = {},
  cmd = 'Trouble',
  keys = {
    { ']t', '<cmd>Trouble next<cr><cmd>Trouble jump<cr>', { silent = true } },
    { '[t', '<cmd>Trouble prev<cr><cmd>Trouble jump<cr>', { silent = true } },
    { ']j', '<cmd>Trouble jump<cr>',                      { silent = true } },
    --{ 'n', '<leader>xw', '<cmd>Trouble workspace_diagnostics<cr>' },
    --{ 'n', '<leader>xd', '<cmd>Trouble document_diagnostics<cr>' },
    --{ 'n', '<leader>xl', '<cmd>Trouble loclist<cr>' },
    --{ 'n', '<leader>xq', '<cmd>Trouble quickfix<cr>' },
  },

  specs = {
    -- Add <C-t> so the Snacks picker window opens files into Trouble.
    'folke/snacks.nvim',
    opts = function(_, opts)
      return vim.tbl_deep_extend('force', opts or {}, {
        picker = {
          actions = require('trouble.sources.snacks').actions,
          win = {
            input = {
              keys = {
                ['<c-t>'] = {
                  'trouble_open',
                  mode = { 'n', 'i' },
                },
              },
            },
          },
        },
      })
    end,
  },
}
