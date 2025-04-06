--- Smorgasbord of small plugins for neovim
return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  opts = {
    dashboard = {
      enabled = true,
      sections = {
        {
          section = 'terminal',
          cmd = '([[ "$(command -v lolcat)" ]] && lolcat --seed=29 $XDG_CONFIG_HOME/dvim/logo.cat) || cat $XDG_CONFIG_HOME/dvim/logo.cat',
          indent = 15,
        },
        { section = 'keys', gap = 1, padding = 3 },
        { section = 'startup', gap = 1 },
      },
    },
    image = { enabled = true },
    notifier = { enabled = true },
    picker = { enabled = true },
    -- Explicitly disable all the others.
    animate = { enabled = false },
    bigfile = { enabled = false },
    dim = { enabled = false },
    gitbrowse = { enabled = false },
    indent = { enabled = true },
    input = { enabled = false },
    layout = { enabled = false },
    lazygit = { enabled = false },
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
    {
      'gd',
      function()
        Snacks.picker.lsp_definitions()
      end,
      desc = '[G]oto [D]efinition',
    },
    {
      'gr',
      function()
        Snacks.picker.lsp_references()
      end,
      desc = '[G]oto [R]eferences',
      nowait = true,
    },
    {
      'gI',
      function()
        Snacks.picker.lsp_implementations()
      end,
      desc = '[G]oto [I]mplementation',
    },
    {
      'gy',
      function()
        Snacks.picker.lsp_type_definitions()
      end,
      desc = '[G]oto T[y]pe Definition',
    },

    {
      '<leader>fb',
      function()
        Snacks.picker.buffers()
      end,
      desc = '[F]ind [b]uffers',
    },
    {
      '<leader>ff',
      function()
        Snacks.picker.files()
      end,
      desc = '[F]ind [f]iles',
    },
    {
      '<leader>fg',
      function()
        Snacks.picker.grep()
      end,
      desc = '[G]rep',
    },
    {
      '<leader>fh',
      function()
        Snacks.picker.help()
      end,
      desc = '[F]ind [h]elp',
    },
    {
      '<leader>fu',
      function()
        Snacks.picker.undo()
      end,
      desc = '[F]ind in [u]ndofile history',
      mode = { 'n', 'x' },
    },
    {
      '<leader>fw',
      function()
        Snacks.picker.grep_word({
          search = vim.fn.mode() == 'v' and dvim.utils.get_visual_selection()
            or dvim.utils.save_and_expand_cword(),
          title = 'Find word or selection',
        })
      end,
      desc = '[F]ind [w]ord or selection',
      mode = { 'n', 'x' },
    },

    {
      '<leader>fd',
      function()
        Snacks.picker.grep_word({
          search = 'def '
            .. (
              vim.fn.mode() == 'v' and dvim.utils.get_visual_selection()
              or dvim.utils.save_and_expand_cword()
            ),
          title = 'Find method definitions',
        })
      end,
      desc = '[F]ind method [d]efinitions',
      ft = { 'ruby', 'eruby', 'elixir', 'eelixir', 'heex' },
      mode = { 'n', 'v' },
    },

    {
      '<leader>fl',
      function()
        Snacks.picker.grep_word({
          cwd = 'config/locales',
          pattern = 'file:yml$',
          search = vim.fn.mode() == 'v' and dvim.utils.get_visual_selection()
            or dvim.utils.save_and_expand_cword(),
          live = true,
          title = 'Rails translations',
        })
      end,
      desc = '[F]ind Rails translations in [l]ocale files',
      ft = { 'ruby', 'eruby', 'eruby.yaml' },
      mode = { 'n', 'v' },
    },
  },
}
