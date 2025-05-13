return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  opts = {
    preset = 'helix',
    win = {
      -- border = { '┏', '━', '┓', '┃', '┛', '━', '┗', '┃' },
      border = { '┌', '─', '┐', '│', '┘', '─', '└', '│' },
    },
  },
  keys = {
    {
      '<leader>?',
      function()
        require('which-key').show({ global = false })
      end,
      desc = 'Buffer Local Keymaps (which-key)',
    },
  },
}
