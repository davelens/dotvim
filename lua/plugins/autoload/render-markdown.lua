return {
  'MeanderingProgrammer/render-markdown.nvim',
  ft = { 'markdown', 'norg', 'livebook', 'codecompanion' },
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons',
  },
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  opts = {},
}
