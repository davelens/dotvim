return {
  -- nvim looks into $PATH for the executable, but with an absolute path you
  -- can be sure the right version gets selected.
  cmd = { vim.fn.expand('$XDG_DATA_HOME/mise/shims/ruby-lsp') },
  filetypes = { 'ruby', 'eruby' },
  root_markers = { 'Gemfile' },
  -- settings = {
  --   rubyLsp = {
  --     enabledFeatures = {
  --       codeActions = true,
  --       completion = true,
  --       diagnostics = true,
  --       documentHighlights = false,
  --       documentLink = false,
  --       documentSymbols = true,
  --       hover = true,
  --       inlayHint = true,
  --       foldingRanges = false,
  --       formatting = false,
  --       onTypeFormatting = false,
  --       selectionRanges = false,
  --       semanticHighlighting = false,
  --     },
  --   },
  -- },
  init_options = {
    -- formatter = 'standard',
    -- linters = { 'standard' },
    addonSettings = {
      ['Ruby LSP Rails'] = {
        enablePendingMigrationsPrompt = false,
      },
    },
  },
}
