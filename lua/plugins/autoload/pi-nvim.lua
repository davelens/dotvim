return {
  'pablopunk/pi.nvim',
  keys = {
    {
      ';a',
      '<cmd>:PiAsk<CR>',
      desc = 'AI agent prompt',
      mode = 'n',
    },
    {
      ';a',
      '<cmd>:PiAskSelection<CR>',
      desc = 'AI agent prompt (for selection)',
      mode = 'v',
    },
  },
  opts = {
    provider = 'openai-codex',
    model = 'gpt-5.4-mini',
  },
}
