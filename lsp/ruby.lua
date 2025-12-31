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
  --       codeLens = true,
  --       completion = true,
  --       definition = true,
  --       diagnostics = true,
  --       documentHighlights = true,
  --       documentLink = true,
  --       documentSymbols = true,
  --       foldingRanges = true,
  --       formatting = true,
  --       hover = true,
  --       inlayHint = true,
  --       onTypeFormatting = true,
  --       selectionRanges = true,
  --       semanticHighlighting = true,
  --       signatureHelp = true,
  --       typeHierarchy = true,
  --       workspaceSymbol = true
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
