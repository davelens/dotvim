-- Custom textobjects for nvim-treesitter.
-- https://ofirgall.github.io/learn-nvim/chapters/05-text-objects.html
--
-- NOTE: This config uses the nvim-treesitter 1.0 API (main branch).
-- The old API using require('nvim-treesitter.configs').setup() is deprecated.
return {
  'nvim-treesitter/nvim-treesitter-textobjects',
  branch = 'main',
  lazy = true,
  config = function()
    require('nvim-treesitter-textobjects').setup({
      select = {
        -- Automatically jump forward to a textobj.
        lookahead = true,
      },
    })

    local select = require('nvim-treesitter-textobjects.select')

    vim.keymap.set({ 'x', 'o' }, 'af', function()
      select.select_textobject('@function.outer', 'textobjects')
    end, { desc = 'Select outer function' })
    vim.keymap.set({ 'x', 'o' }, 'if', function()
      select.select_textobject('@function.inner', 'textobjects')
    end, { desc = 'Select inner function' })
    vim.keymap.set({ 'x', 'o' }, 'ac', function()
      select.select_textobject('@class.outer', 'textobjects')
    end, { desc = 'Select outer class' })
    vim.keymap.set({ 'x', 'o' }, 'ic', function()
      select.select_textobject('@class.inner', 'textobjects')
    end, { desc = 'Select inner class' })
    vim.keymap.set({ 'x', 'o' }, 'ab', function()
      select.select_textobject('@block.outer', 'textobjects')
    end, { desc = 'Select outer block' })
    vim.keymap.set({ 'x', 'o' }, 'ib', function()
      select.select_textobject('@block.inner', 'textobjects')
    end, { desc = 'Select inner block' })
  end,
}
