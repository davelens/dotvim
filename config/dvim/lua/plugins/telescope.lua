-- Command-line fuzzy finder that is extendable.
return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    { 'nvim-lua/plenary.nvim' },
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    { 'folke/trouble.nvim' },
    { 'nvim-tree/nvim-web-devicons' },
  },
  config = function()
    local telescope = require('telescope')
    local builtin = require('telescope.builtin')
    local actions = require("telescope.actions")
    local trouble = require('trouble.sources.telescope')

    vim.keymap.set('n', '<leader>t', builtin.find_files, {})
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
    vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
    vim.keymap.set('n', '<leader>l', ':<C-U>lua require(\'telescope.builtin\').grep_string({search = vim.fn.expand("<cword>")})<cr>', { silent = true })
    vim.keymap.set('v', '<leader>l', ':<C-U>lua require(\'telescope.builtin\').grep_string({search = get_visual_selection()})<cr>', { silent = true })

    telescope.setup {
      defaults = {
        mappings = {
          -- Open selected files into a Trouble quicklist.
          -- TODO: This worked, but not anymore. Conflict with a plugin probably.
          i = { ['<c-t>'] = trouble.open },
          n = { ['<c-t>'] = trouble.open },
          -- Default is C-X, which I don't like.
          i = { ['<c-s>'] = actions.select_horizontal },
          n = { ['<c-s>'] = actions.select_horizontal },
          -- These are the defaults in junegunn's fzf.
          -- Commented because I want to use Telescope's defaults
          -- and not have them conflict with C-K / C-F.
          -- i = ["<C-k>"] = actions.move_selection_previous,
          -- i = ["<C-j>"] = actions.move_selection_next,
        },
      }
    }

    telescope.load_extension('fzf')
  end,
}
