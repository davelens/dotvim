-- f(orever) undo makes (neo)vim's undofile persistent, even for changes
-- outside of vim. This eats up to 512 MB disk space as a soft limit by default
-- though, so use caution.
--
-- Stores its data in vim.fn.stdpath('data')/fundo/archives
return {
  'kevinhwang91/nvim-fundo',
  dependencies = { 'kevinhwang91/promise-async' },
  event = 'VeryLazy',
  opts = {},
}
