return {
  'olimorris/codecompanion.nvim',
  cmd = {
    'CodeCompanion',
    'CodeCompanionChat',
    'CodeCompanionCmd',
    'CodeCompanionActions',
  },
  opts = {
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
