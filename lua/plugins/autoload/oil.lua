return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  opts = {},
  keys = {
    {
      "<leader>o",
      "<cmd>Oil --float<CR>",
      silent = true,
      desc = 'Open [O]il.nvim'
    },
  },
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  init = function()
    require("oil").setup()
  end,
}
