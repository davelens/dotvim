-- Command-line fuzzy finder that is extendable.
return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'nvim-telescope/telescope-live-grep-args.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  },
  config = function()
    local telescope = require('telescope')
    local trouble = require('trouble.sources.telescope')
    local builtin = require('telescope.builtin')
    local actions = require("telescope.actions")

    vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
    vim.keymap.set('n', '<leader>fg', telescope.extensions.live_grep_args.live_grep_args, {})
    vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
    vim.keymap.set('n', '<leader>l', ':<C-U>lua require(\'telescope.builtin\').grep_string({search = vim.fn.expand("<cword>")})<cr>', { silent = true })
    vim.keymap.set('v', '<leader>l', ':<C-U>lua require(\'telescope.builtin\').grep_string({search = get_visual_selection()})<cr>', { silent = true })

    telescope.setup {
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
      },
      defaults = {
        mappings = {
          i = { 
            ['<c-t>'] = trouble.open, -- Open selected files into a Trouble quicklist.
            ['<c-s>'] = actions.select_horizontal, -- Default is C-X, which I don't like.
          },
          n = { 
            ['<c-t>'] = trouble.open, -- Open selected files into a Trouble quicklist.
            ['<c-s>'] = actions.select_horizontal, -- Default is C-X, which I don't like.
          }
        },
      }
    }

    telescope.load_extension('fzf')
    telescope.load_extension("live_grep_args")
    telescope.load_extension("notify")
  end,
}
