-- Structured and colored vim status bar.
return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('lualine').setup({
      options = { theme = vim.colorscheme }
    })
  end
}
