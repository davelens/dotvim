return {
  -- nvim looks into $PATH for the executable, but with an absolute path you
  -- can be sure the right version gets selected.
  cmd = { vim.fn.expand("$XDG_DATA_HOME/asdf/shims/ruby-lsp") },
  filetypes = { 'ruby', 'eruby' },
  root_markers = { 'Gemfile' },
  -- init_options = {
  --   formatter = 'standard',
  --   linters = { 'standard' },
  -- },
}
