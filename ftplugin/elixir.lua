-- Set the exunit compiler for Elixir test files.
-- This enables proper quickfix integration with vim-dispatch.
if vim.fn.expand('%'):match('_test%.exs$') then
  vim.cmd('compiler exunit')
end

dvim.load({
  module = 'config.functions.elixir',
  pattern = { '*.ex', '*.html.heex' },
  autocommands = function(heex)
    vim.schedule(function()
      vim.keymap.set(
        'v',
        'wg',
        heex.wrap_with_gettext,
        { noremap = true, silent = false, buffer = true }
      )
    end)
  end,
})
