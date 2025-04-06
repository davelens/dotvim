-- Structured and colored vim status bar.
return {
  'nvim-lualine/lualine.nvim',
  opts = {
    theme = vim.colorscheme,
    options = {
      disabled_filetypes = { 'snacks_dashboard' },
    },
  },
}
