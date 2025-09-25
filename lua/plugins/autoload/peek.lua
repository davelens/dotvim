-- Markdown preview plugin for Neovim.
return {
  'toppair/peek.nvim',
  build = 'deno task --quiet build:fast',
  opts = {},
  ft = 'markdown',
  -- Thinking I should use an autocommand here instead of a keymap.
  keys = {
    {
      ';m',
      function()
        peek = require('peek')
        return peek.is_open() and peek.close() or peek.open()
      end,
      ft = 'markdown',
      desc = 'Markdown preview (peek.nvim)',
    },
  },
}
