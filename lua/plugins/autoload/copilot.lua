-- AI pair programmer :x
return {
  'zbirenbaum/copilot.lua',
  enabled = false,
  ft = {
    'css',
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
    'yaml',
  },
  opts = {
    filetypes = {
      yaml = true,
    },
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
