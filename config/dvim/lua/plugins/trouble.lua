return { 
  'folke/trouble.nvim', 
  opts = {}, 
  cmd = "Trouble",
  keys = {
    { "]q", "<cmd>Trouble next<cr>", { silent = true } },
    { "[q", "<cmd>Trouble prev<cr>", { silent = true } },
    --{ "n", "<leader>xw", "<cmd>TroubleToggle lsp_workspace_diagnostics<cr>" },
    --{ "n", "<leader>xd", "<cmd>TroubleToggle lsp_document_diagnostics<cr>" },
    --{ "n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>" },
    --{ "n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>" },
    --{ "n", "gR", "<cmd>TroubleToggle lsp_references<cr>" },
  },
  config = function()
    local map = vim.keymap.set

    local function is_trouble_open()
      for _, win in ipairs(vim.api.nvim_list_wins()) do
        local buf = vim.api.nvim_win_get_buf(win)
        local filetype = vim.api.nvim_buf_get_option(buf, "filetype")
        if filetype == "trouble" then
          return true
        end
      end

      return false
    end

    -- If Trouble is open, it will use the same 
    map('n', "<leader>qc", function() 
      if is_trouble_open() then
        vim.cmd("Trouble close")
      else
        vim.cmd("ccl")
      end
    end, {})

  end
}
