-- AI pair programmer :x
return {
  'zbirenbaum/copilot.lua',
  ft = {
    'html', 'css', 'scss',
    'ruby', 'eruby', 'eruby.yaml',
    'elixir', 'eelixir', 'heex',
    'javascript', 'typescript',
    'lua'
  },
  opts = {
    suggestion = {
      auto_trigger = true,
      keymap = {
        accept = "<C-l>",
        next = "<C-u>",
        prev = "<C-i>",
      },
    },
  },
}
