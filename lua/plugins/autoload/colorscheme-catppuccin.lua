return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
  opts = {
    float = {
      transparent = true,
    },
    dim_inactive = {
      enabled = true,
    },
    integrations = {
      snacks = true,
    },
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
      }
    end,
  },
  -- This is a wee trick: init() runs before config(), but using vim.schedule()
  -- allows me to defer the colorscheme setting somehwere further along the
  -- main event loop. I don't like overriding config() directly.
  -- This was not required in Neovim 0.11, but 0.12 changed it somehow.
  init = function()
    vim.schedule(function()
      vim.cmd.colorscheme('catppuccin')
    end)
  end,
}
