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
    adapters = {
      acp = {
        claude_code = function()
          return require('codecompanion.adapters').extend('claude_code', {
            env = {
              CLAUDE_CODE_OAUTH_TOKEN = vim.env.CLAUDE_CODE_OAUTH_TOKEN,
            },
          })
        end,
      },
    },
    strategies = {
      chat = {
        adapter = 'claude_code',
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
      cmd = { adapter = 'claude_code' },
    },
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
}
