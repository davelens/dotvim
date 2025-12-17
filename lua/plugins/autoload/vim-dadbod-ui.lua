return {
  'kristijanhusak/vim-dadbod-ui',
  dependencies = {
    { 'tpope/vim-dadbod', lazy = true },
    {
      'kristijanhusak/vim-dadbod-completion',
      ft = { 'sql', 'mysql', 'psql' },
      lazy = true,
    },
  },
  cmd = {
    'DBUI',
    'DBUIToggle',
  },
  keys = {
    { ';d', '<cmd>DBUIToggle<cr>', desc = 'Database (vim-dadbod)' },
  },
  init = function()
    vim.g.db_ui_use_nerd_fonts = 1
  end,
}
