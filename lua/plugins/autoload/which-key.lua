return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  opts = {
    preset = 'helix',
    win = {
      border = 'single',
      -- This is like `double` but "fuller". Don't think it has a preset name.
      -- border = { '┏', '━', '┓', '┃', '┛', '━', '┗', '┃' },
    },
    spec = {
      { ' ', desc = 'Actions' },
      { ';', desc = 'Toggles' },
      { ';c', group = '[C]odeCompanion' },
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
