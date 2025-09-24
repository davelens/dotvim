return {
  'olimorris/codecompanion.nvim',
  cmd = {
    'CodeCompanion',
    'CodeCompanionChat',
    'CodeCompanionCmd',
    'CodeCompanionActions',
  },
  keys = {
    -- { ';cp', '<cmd>CodeCompanion<cr>', desc = '[P]rompt inline' },
    -- { ';ca', '<cmd>CodeCompanionActions<cr>', desc = '[A]ctions palette' },
    -- { ';cg', '<cmd>CodeCompanionCmd<cr>', desc = '[G]enerate shell command' },
    {
      ';a',
      '<cmd>CodeCompanionChat Toggle<cr>',
      desc = 'AI agent (codecompanion.nvim)',
      mode = 'n',
    },
    {
      ';a',
      ':CodeCompanion #{buffer} ',
      desc = 'AI (prompt for selection)',
      mode = 'v',
    },
  },
  opts = {
    display = {
      chat = {
        window = {
          layout = 'float',
        },
      },
    },
    opts = {
      log_level = 'ERROR', -- Here for when I need it changed to DEBUG quickly.
    },
    strategies = {
      chat = {
        adapter = 'copilot',
        model = 'gpt5',
        keymaps = {
          close = {
            modes = { n = 'q' },
          },
          next_chat = {
            modes = { n = 'cn' },
          },
          previous_chat = {
            modes = { n = 'cp' },
          },
        },
      },
      inline = { adapter = 'copilot' },
      cmd = { adapter = 'copilot' },
    },
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
}
