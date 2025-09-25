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
      { ']', desc = 'Jump forward', mode = { 'n', 'v' } },
      { '[', desc = 'Jump backward', mode = { 'n', 'v' } },

      { ';', desc = 'Toggles', mode = { 'n', 'v' } },
      { ';a', group = 'AI agent', mode = { 'n', 'v' } },

      { ' ', desc = 'Actions', mode = { 'n', 'v' } },
      { ' b', desc = 'Buffers' },
      { ' c', desc = 'Comments', mode = { 'n', 'v' } },
      { ' d', desc = 'Diagnostics' },
      { ' f', desc = 'Fuzzy finder', mode = 'n', 'v' },
      { ' g', desc = 'Git' },
      { ' l', desc = 'LSP' },
      { ' q', desc = 'Quickfix' },
      { ' w', desc = 'Window' },
    },
  },
  keys = {
    {
      '<leader>b?',
      function()
        require('which-key').show({ global = false })
      end,
      desc = 'Local Keymaps (which-key)',
    },
  },
}
