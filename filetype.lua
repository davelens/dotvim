-- Register the 'todo' filetype and use treesitter to highlight as markdown
vim.filetype.add({
  pattern = { ['todo.md'] = 'TODO' },
})

vim.treesitter.language.register('markdown', 'TODO')
