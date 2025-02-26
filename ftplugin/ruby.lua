-- Indentation and whitespace defaults
-- See this screencast to learn how these interoperate:
-- http://vimcasts.org/episodes/tabs-and-spaces/
vim.opt_local.autoindent = true  -- Copy indents from current line when moving to a new line
vim.opt_local.cindent = true     -- Automatic C-style indenting for non-C files
vim.opt_local.expandtab = true   -- Forces spaces instead of tab characters
vim.opt_local.shiftwidth = 2     -- Use 2 spaces as default indent width when using << >>
vim.opt_local.smartindent = true -- Smart(ish) autoindenting when starting a new line
-- Inserts/Deletes whitespace in front of lines according to the above settings
vim.opt_local.smarttab = true
vim.opt_local.softtabstop = 2 -- Determines how much whitespace is used while indenting
vim.opt_local.tabstop = 2     -- The width of a tab character

-- RSpec configuration
--
-- NOTE: This is a both a learning exercise, and an experiment:
-- - All my RSpec related functionality is kept in a separate module file.
-- - I only want to make use of those methods to bind them to keymaps when the
-- file pattern is *_rspec.rb.
-- - There is no specific RSpec filetype in Vim, so to keep everything separated
-- - I want to unload RSpec functionality when I leave those buffers.
--
-- I opted to load them through `dvim.load()`. The callback gets executed
-- for every BufEnter of the given pattern, and unloads the module from dvim as
-- we leave relevant buffers.
-- This method saves me from defining augroup/aucmds every time.
dvim.load({
  module = 'config.functions.rspec',
  pattern = '*_spec.rb',
  autocommands = function(rspec)
    vim.schedule(
      function()
        vim.keymap.set(
          'n',
          '<leader>rl',
          rspec.refactor_assignment_to_let,
          { noremap = true, silent = false, buffer = true }
        )
      end
    )
  end
})
