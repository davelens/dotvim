vim.filetype.add({
  -- Exact basenames belong under `filename`; as `pattern` keys they were
  -- unanchored Lua patterns (`.` matched any char, so `mytodo.md` matched too).
  filename = {
    ['todo.md'] = 'TODO',
    ['TODO.md'] = 'TODO',
  },
  pattern = {
    ['.*%.env'] = 'conf',
  },
})

-- The TODO filetype should syntax highlight as markdown.
vim.treesitter.language.register('markdown', 'TODO')

-- Compound filetypes for YAML with embedded Ruby (Rails i18n locale files).
-- eruby.yaml is the default when opening these files.
vim.treesitter.language.register('yaml', 'eruby.yaml')
