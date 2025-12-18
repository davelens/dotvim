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
    'yaml.eruby',
  },
  opts = {
    suggestion = {
      enabled = true,
      auto_trigger = false,
      keymap = {
        accept = '<C-l>',
        next = '<C-n>',
        prev = '<C-p>',
      },
    },
    panel = { enabled = false },
  },
}
