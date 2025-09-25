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
      { ' ', mode = { 'n', 'v' }, desc = 'Actions' },
      { ' g', desc = 'Git' },
      { ';', mode = { 'n', 'v' }, desc = 'Toggles' },
      { ';a', group = 'AI agent' },
      { ';e', group = 'Explorer' },
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
