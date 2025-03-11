-- Use GitHub Copilot Chat capabilities directly in Neovim.
return {
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    dependencies = {
      { 'zbirenbaum/copilot.lua' },
      { 'nvim-lua/plenary.nvim', branch = 'master' }, -- for curl, log and async functions
    },
    -- Only on MacOS or Linux
    build = 'make tiktoken',
    cmd = {
      'CopilotChat',
      'CopilotChatOpen',
      'CopilotChatToggle',
      'CopilotChatAgents',
    },
    opts = {},
  },
}
