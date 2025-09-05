return {
  'olimorris/codecompanion.nvim',
  cmd = {
    'CodeCompanion',
    'CodeCompanionChat',
    'CodeCompanionCmd',
    'CodeCompanionActions',
  },
  keys = {
    { ';cp', '<cmd>CodeCompanion', desc = '[C]odeCompanion: Basic [p]rompt' },
    {
      ';ca',
      '<cmd>CodeCompanionActions<cr>',
      desc = '[C]odeCompanion: Perform an [A]ction',
    },
    {
      ';cc',
      '<cmd>CodeCompanionChat<cr>',
      desc = '[C]odeCompanion: Open [c]hat',
    },
    {
      ';cr',
      '<cmd>CodeCompanionCmd<cr>',
      desc = '[C]odeCompanion: [R]un a shell command',
    },
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
