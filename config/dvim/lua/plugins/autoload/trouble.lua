return { 
  'folke/trouble.nvim', 
  opts = {}, 
  cmd = "Trouble",
  keys = {
    { "]t", "<cmd>Trouble next<cr><cmd>Trouble jump<cr>", { silent = true } },
    { "[t", "<cmd>Trouble prev<cr><cmd>Trouble jump<cr>", { silent = true } },
    { "]j", "<cmd>Trouble jump<cr>", { silent = true } },
    --{ "n", "<leader>xw", "<cmd>TroubleToggle lsp_workspace_diagnostics<cr>" },
    --{ "n", "<leader>xd", "<cmd>TroubleToggle lsp_document_diagnostics<cr>" },
    --{ "n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>" },
    --{ "n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>" },
    --{ "n", "gR", "<cmd>TroubleToggle lsp_references<cr>" },
  },
  config = function()
    local map = vim.keymap.set
    local trouble = require('trouble')

    -- Just a generic command ot close both Trouble or the quickfix list.
    -- Trouble windows take precedence if both are open.
    -- NOTE: I might rebind this to something like ]c. I don't think 
    -- vim-unimpaired uses c.
    map('n', "<leader>qc", function() 
      if trouble.is_open() then
        vim.cmd("Trouble close")
      else
        vim.cmd("ccl")
      end
    end, {})

  end
}
