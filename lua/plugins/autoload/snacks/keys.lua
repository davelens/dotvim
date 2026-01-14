-- stylua: ignore
return {
  { '<leader>ld', function() Snacks.picker.lsp_definitions() end, desc = 'Definitions' },
  { '<leader>lr', function() Snacks.picker.lsp_references() end, desc = 'References', nowait = true },
  { '<leader>li', function() Snacks.picker.lsp_implementations() end, desc = 'Implementations' },
  { '<leader>lt', function() Snacks.picker.lsp_type_definitions() end, desc = 'Type definitions' },
  { '<leader>ls', function() Snacks.picker.lsp_symbols() end, desc = 'Symbols' },

  { '<leader>ff', function() Snacks.picker.files() end, desc = 'Files' },
  { '<leader>fr', function() Snacks.picker.recent() end, desc = 'Recent files' },
  { '<leader>fg', function() Snacks.picker.grep() end, desc = 'Grep words' },
  { '<leader>fa', '<cmd>A<cr>', desc = 'Alternate file (vim-rails)' },
  { '<leader>fb', function() Snacks.picker.buffers() end, desc = 'Buffers' },
  { '<leader>fu', function() Snacks.picker.undo() end, desc = 'Undofile history' },
  { '<leader>fn', function() Snacks.picker.notifications() end, desc = 'Notifications history' },
  { '<leader>fk', function() Snacks.picker.keymaps() end, desc = 'Keymaps' },
  { '<leader>fp', function() Snacks.picker.gh_pr() end, desc = 'Pull Requests on GitHub' },
  { '<leader>fc', function() Snacks.picker.files({title = 'Neovim config files', cwd = vim.fn.stdpath('config')}) end, desc = 'Neovim config files' },
  { '<leader>fh', function() Snacks.picker.help() end, desc = 'Help' },

  {
    '<leader>fw',
    function()
      Snacks.picker.grep_word({
        search = vim.fn.mode() == 'v' and dvim.utils.get_visual_selection()
          or dvim.utils.save_and_expand_cword(),
        title = 'Word or selection',
      })
    end,
    desc = 'Word or selection',
    mode = { 'n', 'v' },
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
        title = 'Method definitions',
      })
    end,
    desc = 'Method definitions',
    ft = { 'ruby', 'eruby', 'elixir', 'eelixir', 'heex' },
    mode = { 'n', 'v' },
  },

  {
    '<leader>ftl',
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
    desc = 'Term',
    ft = { 'ruby', 'eruby', 'eruby.yaml', 'yaml.eruby' },
    mode = { 'n', 'v' },
  },
}
