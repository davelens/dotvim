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

-- Overrides vim-test's exunit executable with a docker prefix, but only when
-- the 'phoenix' container is running.
-- NOTE: a distinct `name` avoids colliding with the Ruby docker augroup.
-- `*.exs` is included so entering a test file directly triggers the override.
dvim.load({
  module = 'config.functions.docker',
  name = 'docker_elixir',
  pattern = { '*.ex', '*.exs', '*.html.heex' },
  autocommands = function(docker)
    docker.container_running('phoenix', function(running)
      vim.schedule(function()
        vim.g['test#elixir#exunit#executable'] = running
            and 'docker compose exec phoenix mix test'
          or nil
      end)
    end)
  end,
})
