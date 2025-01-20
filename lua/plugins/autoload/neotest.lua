return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "olimorris/neotest-rspec",
  },

  keys = {
    { "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run File" },
    { "<leader>tt", function() require("neotest").run.run() end, desc = "Run Nearest" },
  },

  config = function()

    local neotest = require("neotest")

    neotest.setup({
      adapters = {
        require("neotest-rspec")({
          rspec_cmd = "bin/rspec"
        })
      },

      status = { virtual_text = true },
      output = { open_on_run = true },

      quickfix = {
        open = function()
          if require("trouble") then
            require("trouble").open({ mode = "quickfix", focus = false })
          else
            vim.cmd("copen")
          end
        end,
      },

    })

  end
}
