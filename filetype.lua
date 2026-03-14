vim.filetype.add({
  pattern = {
    ['.*%.env'] = 'conf',
    ['todo.md'] = 'TODO',
    ['TODO.md'] = 'TODO',
  },
})

-- The TODO filetype should syntax highlight as markdown.
vim.treesitter.language.register('markdown', 'TODO')

-- Compound filetypes for YAML with embedded Ruby (Rails i18n locale files).
-- eruby.yaml is the default when opening these files.
vim.treesitter.language.register('yaml', 'eruby.yaml')
