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

-- RSpec keymap to convert variable assignments to RSpec `let` blocks.
autocmd('BufEnter', {
  group = augroup('rspec'),
  pattern = '*_spec.rb',
  callback = function(_)
    -- Only when an RSpec file is loaded should we load the RSpec utils.
    dvim.utils.assign('rspec', 'config.functions.rspec')
    vim.keymap.set(
      'n',
      '<leader>rl',
      dvim.rspec.refactor_assignment_to_let,
      { noremap = true, silent = false, buffer = true }
    )
  end
})
