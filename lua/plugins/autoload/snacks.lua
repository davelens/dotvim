--- Smorgasbord of small plugins for neovim
return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  opts = {
    animate = { enabled = false },
    bigfile = { enabled = false },
    dashboard = { enabled = false },
    dim = { enabled = false },
    gitbrowse = { enabled = false },
    indent = { enabled = true },
    input = { enabled = false },
    layout = { enabled = false },
    lazygit = { enabled = false },
    notifier = { enabled = false },
    picker = { enabled = true },
    profiler = { enabled = false },
    quickfile = { enabled = false },
    scope = { enabled = false },
    scratch = { enabled = false },
    scroll = { enabled = false },
    statuscolumn = { enabled = false },
    terminal = { enabled = false },
    toggle = { enabled = false },
    win = { enabled = false },
    words = { enabled = false },
    zen = { enabled = false },
    styles = { enabled = false },
  },
  keys = {
    { 'gd',         function() Snacks.picker.lsp_definitions() end,      desc = 'Goto Definition' },
    { 'gr',         function() Snacks.picker.lsp_references() end,       desc = 'References',                 nowait = true },
    { 'gI',         function() Snacks.picker.lsp_implementations() end,  desc = 'Goto Implementation' },
    { 'gy',         function() Snacks.picker.lsp_type_definitions() end, desc = 'Goto T[y]pe Definition' },

    { '<leader>fb', function() Snacks.picker.buffers() end,              desc = 'Find [b]uffers' },
    { '<leader>ff', function() Snacks.picker.files() end,                desc = 'Find [f]iles' },
    { '<leader>fg', function() Snacks.picker.grep() end,                 desc = '[G]rep' },
    { '<leader>fh', function() Snacks.picker.help() end,                 desc = 'Find [h]elp' },
    { '<leader>fu', function() Snacks.picker.undo() end,                 desc = 'Find in [u]ndofile history', mode = { 'n', 'x' } },
    { '<leader>fw', function() Snacks.picker.grep_word() end,            desc = 'Find [w]ord or selection',   mode = { 'n', 'x' } },

    {
      '<leader>fd',
      function()
        Snacks.picker.grep_word({
          search = 'def ' .. (vim.fn.mode() == 'v' and dvim.utils.get_visual_selection() or vim.fn.expand('<cword>')),
          title = 'Find method definitions'
        })
      end,
      desc = 'Find method [d]efinitions',
      ft = { 'ruby', 'eruby', 'elixir', 'eelixir', 'heex' },
      mode = { 'n', 'v' }
    },

    {
      '<leader>fl',
      function()
        Snacks.picker.grep_word({
          cwd = 'config/locales',
          pattern = 'file:yml$',
          search = vim.fn.mode() == 'v' and dvim.utils.get_visual_selection() or vim.fn.expand('<cword>'),
          live = true,
          title = 'Rails translations'
        })
      end,
      desc = 'Find Rails translations in [l]ocale files',
      ft = { 'ruby', 'eruby', 'eruby.yaml' },
      mode = { 'n', 'v' }
    },
  }
}
