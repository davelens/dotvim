return { 
  'folke/trouble.nvim', 
  opts = {}, 
  cmd = "Trouble",
  keys = {
    { "<leader>qc", "<cmd>Trouble close<cr>", { silent = true } },
    { "]q", "<cmd>Trouble next<cr>", { silent = true } },
    { "[q", "<cmd>Trouble prev<cr>", { silent = true } },
    --{ "n", "<leader>xw", "<cmd>TroubleToggle lsp_workspace_diagnostics<cr>" },
    --{ "n", "<leader>xd", "<cmd>TroubleToggle lsp_document_diagnostics<cr>" },
    --{ "n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>" },
    --{ "n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>" },
    --{ "n", "gR", "<cmd>TroubleToggle lsp_references<cr>" },
  },
}
