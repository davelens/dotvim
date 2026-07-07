return {
  'stevearc/oil.nvim',
  -- Load at startup so oil hijacks directory buffers (e.g. `nvim some/dir/`);
  -- netrw is disabled, so keys-only lazy loading would leave those empty.
  lazy = false,
  ---@module 'oil'
  opts = {
    float = {
      border = 'single',
      max_width = 79,
      max_height = math.floor(vim.o.lines * 0.6),
    },
    view_options = {
      show_hidden = true,
    },
  },
  keys = {
    {
      ';e',
      '<cmd>Oil --float<CR>',
      silent = true,
      desc = 'Explorer (oil.nvim)',
    },
    { ';e', '<cmd>q<cr>', ft = 'oil', desc = 'Explorer (close)' },
  },
}
