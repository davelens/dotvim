-- Toggles the terminal buffer and runs the current file in Elixir.
function toggle_elixir_runner()
  vim.cmd('w')
  vim.cmd('split | terminal elixir ' .. vim.fn.shellescape(vim.fn.expand('%')))
  vim.cmd('startinsert')
end

-- Keymap for .ex and .exs files
-- TODO: I think I can rely on vim-test again now, but I need to test it first.
vim.keymap.set(
  'n',
  '<CR>',
  '<cmd>lua toggle_elixir_runner()<CR>',
  { noremap = true, silent = true, buffer = true }
)

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
