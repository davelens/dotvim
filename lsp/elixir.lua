return {
  cmd = { 'elixir-ls' },
  filetypes = { 'elixir', 'eelixir', 'heex' },
  root_markers = { 'mix.exs' },
  settings = {
    elixirLS = {
      dialyzerEnabled = false,
      fetchDeps = false,
      plugins = {
        phoenix = {
          enabled = true,
          liveSocketEnabled = true,
        },
      },
    },
  },
}
