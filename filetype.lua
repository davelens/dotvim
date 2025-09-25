vim.filetype.add({
  pattern = {
    ['.*%.env'] = 'conf',
    ['todo.md'] = 'TODO',
  },
})

-- The TODO filetype should syntax highlight as markdown.
vim.treesitter.language.register('markdown', 'TODO')
