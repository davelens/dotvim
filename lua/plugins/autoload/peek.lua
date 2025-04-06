-- Markdown preview plugin for Neovim.
return {
  'toppair/peek.nvim',
  build = 'deno task --quiet build:fast',
  opts = {},
  ft = 'markdown',
  -- Thinking I should use an autocommand here instead of a keymap.
  keys = {
    {
      '<leader>tp',
      function()
        peek = require('peek')
        return peek.is_open() and peek.close() or peek.open()
      end,
      ft = 'markdown',
      desc = '[T]oggle [P]eek preview window',
    },
  },
}
