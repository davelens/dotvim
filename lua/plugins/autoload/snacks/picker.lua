return {
  enabled = true,
  formatters = {
    file = {
      truncate = vim.o.columns > 125 and 85 or 50,
    },
  },
  layouts = {
    default = {
      layout = {
        box = 'horizontal',
        width = 0.8,
        min_width = 120,
        height = 0.8,
        {
          box = 'vertical',
          border = 'single',
          title = '{title} {live} {flags}',
          { win = 'input', height = 1, border = 'bottom' },
          { win = 'list', border = 'none' },
        },
        {
          win = 'preview',
          title = '{preview}',
          border = 'single',
          width = 0.5,
        },
      },
    },
  },
}
