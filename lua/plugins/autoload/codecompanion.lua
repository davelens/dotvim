return {
  'olimorris/codecompanion.nvim',
  cmd = { 'CodeCompanion' },
  opts = {
    opts = {
      log_level = 'DEBUG',
    },
    strategies = {
      chat = { adapter = 'copilot' },
      inline = { adapter = 'copilot' },
      cmd = { adapter = 'copilot' },
    },
    -- prompts = {
    --   explain = 'Explain this code',
    --   commit = 'Write a commit message for the following changes',
    --   tests = 'Write tests for this code',
    --   fix = 'Fix the following code',
    -- },
    -- adapters = {
    --   openai = function()
    --     return require('codecompanion.adapters').extend('openai', {
    --       env = { api_key = vim.env.OPENAI_API_KEY },
    --       -- schema = { model = { default = 'gpt-4.1' }, temperature = 0.7 },
    --     })
    --   end,
    -- },
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
}
