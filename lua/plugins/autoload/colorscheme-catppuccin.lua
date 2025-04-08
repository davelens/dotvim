return {
  'catppuccin/nvim',
  flavour = 'auto', -- latte, frappe, macchiato (default), mocha
  event = 'VeryLazy',
  name = 'catppuccin',
  priority = 1000,
  opts = {
    custom_highlights = function(colors)
      return {
        -- folke/lazy.nvim
        IncSearch = { bg = colors.lavender },
        -- zbirenbaum/copilot.lua
        CopilotSuggestion = { fg = colors.subtext0 },
        CopilotAnnotation = { fg = colors.subtext0 },
        -- Also colours noice.nvim's borders.
        DiagnosticInfo = { fg = colors.lavender },
        DiagnosticSignInfo = { fg = colors.lavender },
        DiagnosticSignWarning = { fg = colors.lavender },
        -- Default color for borders on floats.
        FloatBorder = { fg = colors.lavender },
        -- Snacks overrides
        SnacksDashboardIcon = { fg = colors.lavender },
        SnacksDashboardDesc = { fg = colors.lavender },
        SnacksDashboardKey = { fg = colors.lavender },
        SnacksDashboardFooter = { fg = colors.text },
        SnacksDashboardSpecial = { fg = colors.lavender },
        SnacksIndent = { fg = colors.overlay0 },
        SnacksIndentScope = { fg = colors.subtext0 },
        SnacksIndentChunk = { fg = colors.subtext0 },
      }
    end,
  },
  init = function()
    vim.cmd.colorscheme('catppuccin')
  end,
}
