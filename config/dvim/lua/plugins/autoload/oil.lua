return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  opts = {},
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require("oil").setup()
  end,
}
