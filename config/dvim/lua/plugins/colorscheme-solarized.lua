-- Pretty and/or healthy colours for long programming sessions.
return {
  "craftzdog/solarized-osaka.nvim",
  lazy = false,
  priority = 1000,
  opts = {},
  config = function()
    vim.cmd[[colorscheme solarized-osaka]]
  end
}
