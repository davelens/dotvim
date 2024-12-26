return { 
  'folke/trouble.nvim', 
  opts = {}, 
  cmd = "Trouble",
  keys = {
    { "]t", "<cmd>Trouble next<cr><cmd>Trouble jump<cr>", { silent = true } },
    { "[t", "<cmd>Trouble prev<cr><cmd>Trouble jump<cr>", { silent = true } },
    { "]j", "<cmd>Trouble jump<cr>", { silent = true } },
    --{ "n", "<leader>xw", "<cmd>Trouble workspace_diagnostics<cr>" },
    --{ "n", "<leader>xd", "<cmd>Trouble document_diagnostics<cr>" },
    --{ "n", "<leader>xl", "<cmd>Trouble loclist<cr>" },
    --{ "n", "<leader>xq", "<cmd>Trouble quickfix<cr>" },
  },
}
