return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  dependencies = {
    { 'echasnovski/mini.nvim', version = '*' },
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
  config = function()
    require('mini.icons').setup()
  end
}
