-- Markdown preview plugin for Neovim.
return {
  "toppair/peek.nvim",
  event = "VeryLazy",
  build = "deno task --quiet build:fast",
  opts = {},
  keys = {
    {
      "<leader>cp",
      function()
        require("peek").open()
      end,
    },
  },
}
