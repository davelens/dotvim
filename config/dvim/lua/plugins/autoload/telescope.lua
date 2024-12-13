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
    local builtin = require('telescope.builtin')
    local actions = require("telescope.actions")

    vim.keymap.set('n', 'gd', builtin.lsp_definitions, { silent = true })
    vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
    vim.keymap.set('n', '<leader>fg', telescope.extensions.live_grep_args.live_grep_args, {})
    vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
    vim.keymap.set('n', '<leader>l', ':<C-U>lua require(\'telescope.builtin\').grep_string({search = vim.fn.expand("<cword>")})<cr>', { silent = true })
    vim.keymap.set('v', '<leader>l', ':<C-U>lua require(\'telescope.builtin\').grep_string({search = get_visual_selection()})<cr>', { silent = true })

    telescope.setup {
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
        }
      },
      defaults = {
        file_ignore_patterns = { 
          'vendor', 'node_modules', 'db/seeds', 'tmp', 'public/uploads', 
          'coverage', 'dist', 'build', 'deps', 'yarn.lock', 'package-lock.json',
          'Gemfile.lock',
          '%.jpg', '%.jpeg', '%.png', '%.gif', '%.webp', '%.ico', '%.svg', 
          '%.eot', '%.ttf', '%.woff', '%.woff2', '%.otf',
        },
        mappings = {
          -- TODO: Using fzf.vim I used to be able to select files, then press
          -- either <C-s> or <C-v> to open the file in a split or vertical 
          -- split AND have the smart selection in a quickfix window.
          -- That behaviour is not present in Telescope by default, but it
          -- should be possible to get there with a custom mapping.
          i = { 
            ['<C-x>'] = nil, -- Bound the linked behaviour to C-s
            ['<M-q>'] = nil, -- Bound the linked behaviour to C-q
            ['<C-s>'] = actions.select_horizontal,
            ['<C-q>'] = actions.smart_send_to_qflist + actions.open_qflist,
          },
          n = { 
            ['<C-x>'] = nil, -- Bound the linked behaviour to C-s
            ['<M-q>'] = nil, -- Bound the linked behaviour to C-q
            ['<C-s>'] = actions.select_horizontal,
            ['<C-q>'] = actions.smart_send_to_qflist + actions.open_qflist,
          }
        },
      }
    }

    telescope.load_extension('fzf')
    telescope.load_extension("live_grep_args")
    telescope.load_extension("notify")
  end,
}
