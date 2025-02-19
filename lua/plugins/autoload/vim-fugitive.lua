-- Git wrapper for (n)vim.
return {
  "tpope/vim-fugitive",
  keys = { 
    { "<leader>g", "<cmd>G<cr>" },
    { "gu", "<cmd>Git pull<cr>", ft = "fugitive" },
    { "gp", "<cmd>Git push<cr>", ft = "fugitive" },
  },
  -- no opts needed here since this is a pure vim plugin.
}
