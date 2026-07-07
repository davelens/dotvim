return {
  'folke/trouble.nvim',
  opts = {},
  -- No VeryLazy event: cmd/keys are the real lazy-load triggers.
  cmd = 'Trouble',
  keys = {
    {
      ']t',
      '<cmd>Trouble next<cr><cmd>Trouble jump<cr>',
      silent = true,
      desc = 'Next Trouble item',
    },
    {
      '[t',
      '<cmd>Trouble prev<cr><cmd>Trouble jump<cr>',
      silent = true,
      desc = 'Previous Trouble item',
    },
    {
      ']j',
      '<cmd>Trouble jump<cr>',
      silent = true,
      desc = 'Jump to Trouble item',
    },
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
