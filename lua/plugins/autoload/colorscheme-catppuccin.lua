return {
  'catppuccin/nvim',
  flavour = 'auto', -- latte, frappe, macchiato (default), mocha
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
        -- Default color for float borders.
        FloatBorder = { fg = colors.lavender },
        SnacksDashboardIcon = { fg = colors.lavender },
        SnacksDashboardDesc = { fg = colors.lavender },
        SnacksDashboardKey = { fg = colors.lavender },
        SnacksDashboardFooter = { fg = colors.text },
        SnacksDashboardSpecial = { fg = colors.lavender },
      }
    end,
  },
  init = function()
    vim.cmd.colorscheme('catppuccin')
  end,
}
