-- Markdown preview plugin for Neovim.
return {
  'toppair/peek.nvim',
  build = 'deno task --quiet build:fast',
  opts = {},
  ft = 'markdown',
  -- Thinking I should use an autocommand here instead of a keymap.
  keys = {
    {
      '<leader>cp',
      '<cmd>lua require("peek").open()<cr>',
    },
  },
}
