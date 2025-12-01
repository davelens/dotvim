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
