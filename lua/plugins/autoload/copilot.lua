-- AI pair programmer :x
return {
  'zbirenbaum/copilot.lua',
  ft = {
    'css',
    'eelixir',
    'elixir',
    'eruby',
    'eruby.yaml',
    'heex',
    'html',
    'javascript',
    'lua',
    'ruby',
    'scss',
    'sh',
  },
  opts = {
    suggestion = {
      auto_trigger = true,
      keymap = {
        accept = '<C-l>',
        next = '<C-u>',
        prev = '<C-i>',
      },
    },
  },
}
