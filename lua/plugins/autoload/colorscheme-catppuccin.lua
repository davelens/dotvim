return {
  "catppuccin/nvim",
  flavour = "auto", -- latte, frappe, macchiato (default), mocha
  name = "catppuccin",
  priority = 1000,
  opts = {
    custom_highlights = function(colors)
      return {
        -- folke/lazy.nvim
        IncSearch = { bg = colors.lavender },
        -- zbirenbaum/copilot.lua
        CopilotSuggestion = { fg = '#83a598' },
        CopilotAnnotation = { fg = '#83a598' }
      }
    end,
  },
  init = function()
    vim.cmd.colorscheme "catppuccin"
  end
}
