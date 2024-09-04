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

    telescope.setup {
      defaults = {
        mappings = {
          -- Open selected files into a Trouble quicklist.
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
