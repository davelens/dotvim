return {
  'olimorris/codecompanion.nvim',
  cmd = {
    'CodeCompanion',
    'CodeCompanionChat',
    'CodeCompanionCmd',
    'CodeCompanionActions',
  },
  keys = {
    {
      '<leader>a',
      '<cmd>CodeCompanionActions<cr>',
      desc = 'AI (codecompanion.nvim)',
    },
    {
      ';a',
      '<cmd>CodeCompanionChat Toggle<cr>',
      desc = 'AI agent (codecompanion.nvim)',
      mode = 'n',
    },
    {
      ';a',
      '<cmd>CodeCompanion<cr>',
      desc = 'AI agent (prompt for selection)',
      mode = 'v',
    },
  },
  opts = {
    log_level = 'ERROR', -- Here for when I need it changed to DEBUG quickly.
    display = {
      chat = {
        window = {
          layout = 'float',
        },
      },
    },
    interactions = {
      chat = { adapter = 'opencode' },
      inline = { adapter = 'openai' },
      cmd = { adapter = 'opencode' },
    },
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
}
